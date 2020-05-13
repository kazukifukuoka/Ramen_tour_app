# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :request_path
  MY_PAGE_PER = 6
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def show
    @user = User.find(params[:id])
    @post_ramen_store = current_user.ramen_stores.page(params[:page]).per(MY_PAGE_PER)
  end

  def new_guest
    user = User.new_guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました'
  end

  def after_sign_out_path_for(_resource)
    new_user_session_path(@user)
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
