require "test_helper"

class AccountTest < ActiveSupport::TestCase
  setup do
    @account = Account.create!(user_id: 1, asset_id: 1, balance: 100)
  end

  test "available_balance equals balance when there are no orders" do
    assert_equal 100, @account.available_balance
  end

  test "available_balance subtracts sum of funded_amounts from active orders" do
    order1 = @account.orders.create!(
      sell_asset_id: "btc",
      buy_asset_id: "usd",
      sell_amount: 20,
      buy_amount: 1000000
    )
    order1.update_column(:funded_amount, 10)

    order2 = @account.orders.create!(
      sell_asset_id: "btc",
      buy_asset_id: "usd",
      sell_amount: 30,
      buy_amount: 1500000
    )
    order2.update_column(:funded_amount, 15)

    assert_equal 75, @account.available_balance
  end

  test "available_balance ignores completed orders" do
    @account.orders.create!(
      sell_asset_id: "btc",
      buy_asset_id: "usd",
      sell_amount: 50,
      buy_amount: 2500000,
      completed: true
    )

    assert_equal 100, @account.available_balance
  end

  test "available_balance ignores cancelled orders" do
    @account.orders.create!(
      sell_asset_id: "btc",
      buy_asset_id: "usd",
      sell_amount: 50,
      buy_amount: 2500000,
      cancelled_at: Time.current
    )

    assert_equal 100, @account.available_balance
  end
end
