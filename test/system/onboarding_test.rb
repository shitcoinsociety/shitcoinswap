require "application_system_test_case"

class OnboardingTest < ApplicationSystemTestCase
  test 'can sign up, log out, change password, log in' do
    # SIGN UP
    visit '/users/new'

    fill_in 'email', with: 'derp@derp.com'
    fill_in 'password', with: 'derpderp'
    fill_in 'password_confirmation', with: 'derpderp'
    click_on 'signup'

    click_on 'Log out'
    # assert_text 'You have been logged out.'

    click_on 'Log in'
    # click_on 'click here'

    # CHANGE PASSWORD
    click_on 'Forgot your password?'

    fill_in 'email', with: 'derp@derp.com'
    click_on 'Send link'
    assert_text 'Email sent'

    mail = ActionMailer::Base.deliveries.last
    url = mail.body.match(/(\/password_resets\/.*)/)[1]
    visit url

    fill_in 'password', with: 'newpass'
    fill_in 'password_confirmation', with: 'newpass'

    click_on 'Set new password'



    # TRY WRONG PASSWORD
    click_on 'Log in'
    # click_on 'click here'

    fill_in 'email', with: 'derp@derp.com'
    fill_in 'password', with: 'wrongpass'

    click_on 'login'

    assert_text 'Invalid email or password'



    # TRY CORRECT PASSWORD
    fill_in 'email', with: 'derp@derp.com'
    fill_in 'password', with: 'newpass'
    click_on 'login'

    click_on 'logout'

  end
end
