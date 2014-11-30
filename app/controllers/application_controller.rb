class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def after_sign_in_path_for(user)
   "#{request.base_url}/users/#{current_user.id}"
  end

  def after_sign_out_path_for(resource_or_scope)
    request.base_url
  end
end
