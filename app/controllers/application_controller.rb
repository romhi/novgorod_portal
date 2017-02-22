class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  around_filter :set_current_user
  layout :select_by_role
  protect_from_forgery with: :exception
  # layout "admin"

  def set_current_user
    User.current_user = current_user
    yield
  ensure
    # to address the thread variable leak issues in Puma/Thin webserver
    User.current_user = nil
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :first_name, :last_name, :phone, :password, :password_confirmation, :remember_me])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :remember_me])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :password, :password_confirmation, :current_password])
  end

  def select_by_role
    if current_user.try(:admin)
      "admin"
    elsif current_user.try(:manager).to_i == 1
      "manager"
    else
      "application"
    end
  end

  def after_sign_in_path_for(resource)
    (current_user.try(:manager).to_i == 1 or current_user.try(:admin)) ? manager_welcome_index_path : root_path
  end

end
