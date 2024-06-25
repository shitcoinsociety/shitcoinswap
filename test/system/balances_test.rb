require "application_system_test_case"

class BalancesTest < ApplicationSystemTestCase
  test 'balances update in real-time after a deposit' do
    visit '/portfolios'

    fill_in 'email', with: 'joe@shitcoinswap.com'
    fill_in 'password', with: 'password'

    click_on 'login'

    assert_text 'EUR 250.0 available'
  end
end
