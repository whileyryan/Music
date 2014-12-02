class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  # before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!
  skip_before_filter  :verify_authenticity_token


  def after_sign_in_path_for(user)
   "#{request.base_url}/users/#{current_user.id}"
  end

  def after_sign_out_path_for(resource_or_scope)
    request.base_url
  end

   protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end
end
