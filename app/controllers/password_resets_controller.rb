class PasswordResetsController < ApplicationController
  def new

  end

  def create
    user = User.find_by_email(params[:email])
    user.try(:send_password_reset)
  end

  def show
    user = User.find_signed(params[:id], purpose: "password_reset")

    unless user
      flash[:error] = "This link is invalid or has expired."
      redirect_to new_session_path
    end
  end

  def destroy
    user = User.find_signed(params[:id], purpose: "password_reset")
    if user
      if params[:password] != params[:password_confirmation]
        flash[:error] = "The passwords do not match."
        return redirect_back(fallback_location: new_session_path)
      end
      user.password = params[:password]
      user.save!
      flash[:success] = "Your password has been reset. You should be able to log in now."
      redirect_to new_session_path
    else
      flash[:error] = "This link is invalid or has expired."
      redirect_to new_session_path
    end
  end
end
