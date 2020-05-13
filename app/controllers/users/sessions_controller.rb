# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  add_flash_types :success, :info, :warning, :danger
  before_action :request_path
  MY_STORE_PER = 6
  MY_REVIEW_PER = 5
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
    return redirect_to new_user_session_path, danger: 'アカウント登録もしくはログインしてください' unless current_user
    @user = User.find(params[:id])
    @post_ramen_stores = @user.ramen_stores.page(params[:store_page]).per(MY_STORE_PER)
    @post_reviews = @user.ramen_store_reviews.page(params[:review_page]).per(MY_REVIEW_PER)
    high_score_store_ids = Rate.where(rater_id: @user.id, stars: 7..10).order(stars: :desc).pluck(:rateable_id)
    high_score_stores = RamenStore.find(high_score_store_ids)
    @high_score_stores = Kaminari.paginate_array(high_score_stores).page(params[:high_score_store_page]).per(MY_STORE_PER)
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
