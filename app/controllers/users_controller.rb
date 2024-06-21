class UsersController < ApplicationController
  wrap_parameters :user, include: User.attribute_names + [:password, :password_confirmation]

  def new
    @title = "Sign up for Shitcoin Swap"
    return redirect_to projects_path if current_user
  end

  def show
    if params[:id].present?
      user = User.find(params[:id])
      return redirect_to "/@#{user.nickname}"
    end

    @user = User.find_by!(nickname: params[:nickname]).as_json(User::JSON_OPTIONS)
    @title = @user[:name] || @user[:nickname]
  end

  def edit
    user = User.find(params[:id])
    raise ActiveRecord::RecordNotFound if current_user != user
    @user = user.as_json(User::JSON_OPTIONS)
  end

  def update
    user = User.find(params[:id])
    raise ActiveRecord::RecordNotFound if current_user != user
    user.update!(update_params)
    flash[:success] = "Your profile has been updated."
    redirect_to user
  end

  def create
    user = User.new(create_params)

    user.validate!

    # validate turnstile token
    unless check_turnstile_token(params[:turnstile_token])
      flash[:turnstile_error] = 'Invalid captcha'
      return redirect_back(fallback_location: root_path)
    end

    user.last_login_at = Time.now
    user.last_login_ip = request.remote_ip
    user.last_login_user_agent = request.user_agent

    user.save!

    session[:user_id] = user.id
    redirect_to projects_path
  end

  private
  def create_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def update_params
    params.require(:user).permit(:email, :bio, :name, :nickname)
  end


  def check_turnstile_token(token)
    return true unless Rails.env.production?

    url = 'https://challenges.cloudflare.com/turnstile/v0/siteverify'
    data = {
      response: token,
      secret: Rails.application.credentials.turnstile.secret_key,
      ip: request.remote_ip,
      idempotency_key: SecureRandom.uuid,
    }
    response = HTTParty.post(url, body: data.to_json, headers: { 'Content-Type' => 'application/json' })

    return response.parsed_response['success']
  end
end
