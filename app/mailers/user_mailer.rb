class UserMailer < ApplicationMailer
  def password_reset
    @user = params[:user]
    mail to: @user.email
  end
end
