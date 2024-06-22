class ApplicationController < ActionController::Base
  use_inertia_instance_props

  before_action :store_return_to_url
  before_action :redirect_when_logged_in
  before_action :set_current_url_options
  before_action :set_default_meta

  rescue_from ActiveRecord::RecordInvalid do |exception|
    raise exception unless request.inertia?
    session[:errors] = exception.record.errors
    redirect_back(fallback_location: root_path)
  end

  rescue_from ActionController::BadRequest do |exception|
    flash[:error] = exception.message
    redirect_back(fallback_location: root_path)
  end

  inertia_share do
    {
      controller: controller_name,
      action: action_name,
      errors: session.delete(:errors),
      flash: flash.to_h,
      current_user: current_user.as_json(User::PRIVATE_JSON_OPTIONS)
    }
  end

  def set_current_url_options
    ActiveStorage::Current.url_options = {
      host: request.base_url,
      protocol: request.protocol
    }
  end

  def set_default_meta
    @title ||= 'Shitcoin Swap'
  end

  def require_user!

    return if current_user
    if request.method == "GET"
      cookies[:redirect_when_logged_in] = request.fullpath
    end

    redirect_to new_session_path
    # raise ActionController::BadRequest.new('You must be logged in to access this page') unless current_user
  end

  def redirect_when_logged_in
    if current_user && cookies[:redirect_when_logged_in]
      redirect_to cookies.delete(:redirect_when_logged_in)
    end
  end

  def store_return_to_url
    return unless request.get?
    return unless request.referer
    return unless params[:return_to_referer]
    cookies[:redirect_when_logged_in] = request.referer
  end


  def current_user
    Current.user ||= User.find_by(id: session[:user_id])
  end

  def verify_authenticity_token
    super unless request.inertia?
  end


end
