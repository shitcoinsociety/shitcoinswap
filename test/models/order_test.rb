require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test "creating a new order will reduce user's available balance" do
    user = users(:joe)
    initial_balance = user.available_balance(:eur)
    Order.create!(user: user, have_amount: 100, want_amount: 50, have_symbol: 'eur', want_symbol: 'mnt')
    assert_equal initial_balance - 100, user.reload.available_balance(:eur)
  end

  test "cant create an order if user does not have sufficient funds" do
    user = users(:joe)
    eur_balance = user.available_balance(:eur)
    Order.create!(user: user, have_amount: eur_balance, want_amount: 50, have_symbol: 'eur', want_symbol: 'mnt')
    error = assert_raises ActiveRecord::RecordInvalid do
      Order.create!(user: user, have_amount: eur_balance, want_amount: 50, have_symbol: 'eur', want_symbol: 'mnt')
    end
    assert_equal "insufficient funds", error.record.errors[:have_amount].first
  end

  test "matching orders complete eachother" do
    joe = users(:joe)
    sarah = users(:sarah)

    joes_order = joe.orders.create!(have_amount: 100, want_amount: 50, have_symbol: 'eur', want_symbol: 'mnt')
    sarahs_order1 = sarah.orders.create!(have_amount: 20, want_amount: 40, have_symbol: 'mnt', want_symbol: 'eur')
    sarahs_order2 = sarah.orders.create!(have_amount: 20, want_amount: 40, have_symbol: 'mnt', want_symbol: 'eur')
    sarahs_order3 = sarah.orders.create!(have_amount: 20, want_amount: 20, have_symbol: 'mnt', want_symbol: 'eur')

    joes_order.process!

    joes_order.reload
    sarahs_order1.reload
    sarahs_order2.reload
    sarahs_order3.reload

    assert joes_order.completed?
    assert sarahs_order1.completed?
    assert sarahs_order3.completed?
    assert_equal 10, sarahs_order2.remaining_have_amount
    assert_equal 20, sarahs_order2.remaining_want_amount
  end

  test "does not match with higher price" do
    joe = users(:joe)
    sarah = users(:sarah)

    joes_order = joe.orders.create!(have_amount: 100, want_amount: 50, have_symbol: 'eur', want_symbol: 'mnt')
    sarahs_order = sarah.orders.create!(have_amount: 50, want_amount: 101, have_symbol: 'mnt', want_symbol: 'eur')

    assert_not_includes joes_order.matches, sarahs_order
    assert_not_includes sarahs_order.matches, joes_order
  end

end
