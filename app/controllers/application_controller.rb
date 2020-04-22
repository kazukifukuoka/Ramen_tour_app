class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_current_location, unless: :devise_controller?

  private

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

  def store_current_location
    store_location_for(:user, request.url)
  end
end
