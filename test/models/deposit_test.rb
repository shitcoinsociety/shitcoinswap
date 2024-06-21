require "test_helper"

class DepositTest < ActiveSupport::TestCase

  test "creating a new deposit will increase the user's available_balance" do
    user = users(:joe)
    initial_balance = user.available_balance(:eur)
    Deposit.create(user: user, amount: 100, symbol: 'eur')
    assert_equal initial_balance + 100, user.reload.available_balance(:eur)
  end
end
