require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test "creating a new order will reduce user's available balance" do
    user = users(:joe)
    initial_balance = user.available_balance(:eur)
    Order.create!(user: user, sell_amount: 100, buy_amount: 50, sell_symbol: 'eur', buy_symbol: 'mnt')
    assert_equal initial_balance - 100, user.reload.available_balance(:eur)
  end

  test "cant create an order if user does not have sufficient funds" do
    user = users(:joe)
    eur_balance = user.available_balance(:eur)
    Order.create!(user: user, sell_amount: eur_balance, buy_amount: 50, sell_symbol: 'eur', buy_symbol: 'mnt')
    error = assert_raises ActiveRecord::RecordInvalid do
      Order.create!(user: user, sell_amount: eur_balance, buy_amount: 50, sell_symbol: 'eur', buy_symbol: 'mnt')
    end
    assert_equal "insufficient funds", error.record.errors[:sell_amount].first
  end

  test "matching orders complete eachother" do
    joe = users(:joe)
    sarah = users(:sarah)

    joe_initial_eur = joe.available_balance(:eur)
    joe_initial_mnt = joe.available_balance(:mnt)
    sarah_initial_mnt = sarah.available_balance(:mnt)
    sarah_initial_eur = sarah.available_balance(:eur)

    joes_order = joe.orders.create!(sell_amount: 100, buy_amount: 50, sell_symbol: 'eur', buy_symbol: 'mnt')

    # These orders make it so that joe can buy 50 MNT for a total of 80 EUR
    sarahs_order1 = sarah.orders.create!(sell_amount: 20, buy_amount: 40, sell_symbol: 'mnt', buy_symbol: 'eur')
    sarahs_order2 = sarah.orders.create!(sell_amount: 20, buy_amount: 40, sell_symbol: 'mnt', buy_symbol: 'eur')
    sarahs_order3 = sarah.orders.create!(sell_amount: 20, buy_amount: 20, sell_symbol: 'mnt', buy_symbol: 'eur')

    joes_order.process!

    joes_order.reload
    sarahs_order1.reload
    sarahs_order2.reload
    sarahs_order3.reload

    assert joes_order.completed?
    assert sarahs_order1.completed?
    assert sarahs_order3.completed?

    assert_equal 10, sarahs_order2.remaining_sell_amount
    assert_equal 20, sarahs_order2.remaining_buy_amount

    assert_equal joe_initial_eur - 80, joe.available_balance(:eur)
    assert_equal joe_initial_mnt + 50, joe.available_balance(:mnt)
    assert_equal sarah_initial_mnt - 60, sarah.available_balance(:mnt) # 10 MNT are left locked up in the order
    assert_equal sarah_initial_eur + 80, sarah.available_balance(:eur)

  end

  test "no IEEE 754 precision errors (eg. 0.3 - 0.1)" do
    joe = users(:joe)
    sarah = users(:sarah)

    joe_initial_eur = joe.available_balance(:eur)
    joe_initial_mnt = joe.available_balance(:mnt)
    sarah_initial_mnt = sarah.available_balance(:mnt)
    sarah_initial_eur = sarah.available_balance(:eur)

    joes_order = joe.orders.create!(sell_amount: 0.3, buy_amount: 0.1, sell_symbol: 'eur', buy_symbol: 'mnt')
    sarahs_order = sarah.orders.create!(sell_amount: 0.07, buy_amount: 0.1, sell_symbol: 'mnt', buy_symbol: 'eur')

    joes_order.process!

    joes_order.reload
    sarahs_order.reload

    assert_equal 0.03, joes_order.remaining_buy_amount
    assert_equal 0.2, joes_order.remaining_sell_amount
    assert_equal 0, sarahs_order.remaining_buy_amount
    assert_equal 0, sarahs_order.remaining_sell_amount
    assert_equal joe_initial_eur - 0.3, joe.available_balance(:eur)
    assert_equal joe_initial_mnt + 0.07, joe.available_balance(:mnt)
    assert_equal sarah_initial_eur + 0.1, sarah.available_balance(:eur)
    assert_equal sarah_initial_mnt - 0.07, sarah.available_balance(:mnt)
    assert sarahs_order.completed?
  end

  test "does not match with higher price" do
    joe = users(:joe)
    sarah = users(:sarah)

    joes_order = joe.orders.create!(sell_amount: 100, buy_amount: 50, sell_symbol: 'eur', buy_symbol: 'mnt')
    sarahs_order = sarah.orders.create!(sell_amount: 50, buy_amount: 101, sell_symbol: 'mnt', buy_symbol: 'eur')

    assert_not_includes joes_order.matches, sarahs_order
    assert_not_includes sarahs_order.matches, joes_order
  end

  test "unsupported pair will raise" do
    user = users(:joe)
    eur_balance = user.available_balance(:eur)
    error = assert_raises ActiveRecord::RecordInvalid do
      Order.create!(user: user, sell_amount: eur_balance, buy_amount: 50, sell_symbol: 'eur', buy_symbol: 'eur')
    end
    assert_equal "unsupported trading pair", error.record.errors[:base].first
  end

  test "cancelling an order restores user's balance" do
    user = users(:joe)
    initial_balance = user.available_balance(:eur)
    order = Order.create!(user: user, sell_amount: 100, buy_amount: 50, sell_symbol: 'eur', buy_symbol: 'mnt')

    assert_equal initial_balance - 100, user.available_balance(:eur)

    order.cancel!

    assert_equal initial_balance, user.reload.available_balance(:eur)
    assert order.cancelled?
  end

end
