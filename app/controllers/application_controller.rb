class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:surname, :last_name, :country, :state, :local_govt]) #we allow the username for the signup page and account_update page
    devise_parameter_sanitizer.permit(:account_update, keys: [:surname, :last_name, :country, :state, :local_govt])
  end
end

#we dont have to specify if for the email and the password cuz it is already there defaultly


