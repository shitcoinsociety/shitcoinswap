require "test_helper"

class OrderTest < ActiveSupport::TestCase
  setup do
    @usd_account = accounts(:usd_account)
    @btc_account = accounts(:btc_account)
  end

  test "two limit orders at same price fully match and complete each other" do
    # Order A: sell 50,000 USD to buy 1 BTC (price = 50,000 USD/BTC)
    order_a = Order.create!(
      account: @usd_account,
      sell_asset_id: "usd",
      buy_asset_id: "btc",
      sell_amount: 50_000,
      buy_amount: 1
    )

    # Order B: sell 1 BTC to buy 50,000 USD (price = 50,000 USD/BTC equivalent)
    order_b = Order.create!(
      account: @btc_account,
      sell_asset_id: "btc",
      buy_asset_id: "usd",
      sell_amount: 1,
      buy_amount: 50_000
    )

    order_a.reload
    order_b.reload

    assert order_a.completed?, "Order A should be completed"
    assert order_b.completed?, "Order B should be completed"
    assert_equal 0, order_a.remaining_sell_amount, "Order A should have no remaining sell amount"
    assert_equal 0, order_b.remaining_sell_amount, "Order B should have no remaining sell amount"
  end

  test "larger order partially fills against a smaller order" do
    # Order A: sell 100,000 USD to buy 2 BTC (price = 50,000 USD/BTC)
    order_a = Order.create!(
      account: @usd_account,
      sell_asset_id: "usd",
      buy_asset_id: "btc",
      sell_amount: 100_000,
      buy_amount: 2
    )

    # Order B: sell 1 BTC to buy 50,000 USD (price = 50,000 USD/BTC equivalent)
    order_b = Order.create!(
      account: @btc_account,
      sell_asset_id: "btc",
      buy_asset_id: "usd",
      sell_amount: 1,
      buy_amount: 50_000
    )

    order_a.reload
    order_b.reload

    # Order B should be fully filled (it's smaller)
    assert order_b.completed?, "Order B (smaller) should be completed"
    assert_equal 0, order_b.remaining_sell_amount

    # Order A should be partially filled
    assert_not order_a.completed?, "Order A (larger) should NOT be completed"
    assert_equal 50_000, order_a.remaining_sell_amount,
      "Order A should have 50,000 remaining (half filled)"
  end

  test "orders do not match when asset pairs don't align" do
    # Both orders sell USD — no match possible
    order_a = Order.create!(
      account: @usd_account,
      sell_asset_id: "usd",
      buy_asset_id: "btc",
      sell_amount: 50_000,
      buy_amount: 1
    )

    order_b = Order.create!(
      account: @usd_account,
      sell_asset_id: "usd",
      buy_asset_id: "btc",
      sell_amount: 25_000,
      buy_amount: 0.5
    )

    order_a.reload
    order_b.reload

    assert_not order_a.completed?, "Order A should not be completed (no match)"
    assert_not order_b.completed?, "Order B should not be completed (no match)"
    assert_equal 50_000, order_a.remaining_sell_amount
    assert_equal 25_000, order_b.remaining_sell_amount
  end

  test "sell amount exceeding available balance is capped at funded_amount" do
    # usd_account has 100,000 balance; try to sell 200,000
    order_a = Order.create!(
      account: @usd_account,
      sell_asset_id: "usd",
      buy_asset_id: "btc",
      sell_amount: 200_000,
      buy_amount: 4
    )

    order_a.reload
    # funded_amount should be capped to available balance (100,000)
    assert_equal 100_000, order_a.funded_amount, "funded_amount should be capped at available balance"
    assert_equal 200_000, order_a.sell_amount, "sell_amount still reflects the original intent"
    assert_not order_a.completed?, "Order should not be completed — no counterparty yet and sell_amount > funded_amount"
  end
end
