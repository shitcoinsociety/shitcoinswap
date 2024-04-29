class ApplicationController < ActionController::Base
  use_inertia_instance_props

  before_action :set_current_url_options

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
      current_user: current_user
    }
  end

  def set_current_url_options
    ActiveStorage::Current.url_options = {
      host: request.base_url,
      protocol: request.protocol
    }
  end

  def require_user!
    raise ActionController::BadRequest.new('You must be logged in to access this page') unless current_user
  end


  def current_user
    Current.user ||= User.find_by(id: session[:user_id])
  end

  def verify_authenticity_token
    super unless request.inertia?
  end


end
