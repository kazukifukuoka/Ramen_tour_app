class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i[nickname sex image profile]
    )
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: %i[nickname image remove_image profile]
    )
  end
end
