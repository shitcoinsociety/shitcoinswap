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

    error = assert_raises ActiveRecord::RecordInvalid do
      Order.create!(user: user, have_amount: eur_balance + 1, want_amount: 50, have_symbol: 'eur', want_symbol: 'mnt')
    end
    assert_equal "insufficient funds", error.record.errors[:have_amount].first
  end
end
