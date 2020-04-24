class RamenStoresController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_ramen_store, only: %i[show update destroy]

  def top; end

  def index
    @ramen_stores = RamenStore.includes(:user).order(created_at: :desc).page(params[:page])
    return unless params[:tag_name]

    @ramen_stores = RamenStore.tagged_with(params[:tag_name].to_s).page(params[:page])
  end

  def new
    @ramen_store = RamenStore.new
    @ramen_store.menus.build
    2.times { @ramen_store.registered_images.build }
  end

  def show; end

  def create
    @ramen_store = RamenStore.new(ramen_store_params)
    @ramen_store.user_id = current_user.id
    @ramen_store.registered_images.each do |registered_image|
      registered_image.user_id = current_user.id
    end

    if @ramen_store.save
      redirect_to ramen_stores_path, success: '店舗を登録しました'
    else
      flash[:danger] = '店舗の登録に失敗しました'
      render :new
    end
  end

  def edit
    @ramen_store = current_user.ramen_stores.find_by(params[:id])
    if @ramen_store
      RamenStore.find(params[:id])
    else
      flash[:danger] = '投稿者のみ編集できます'
      redirect_to ramen_store_path(params[:id])
    end
  end

  def update
    if @ramen_store.update(ramen_store_params)
      redirect_to ramen_store_path(@ramen_store), success: '店舗を更新しました'
    else
      flash[:danger] = '店舗の更新に失敗しました'
      render :edit
    end
  end

  def destroy
    redirect_to ramen_stores_path, success: '店舗を削除しました' if @ramen_store.destroy!
  end

  def likes
    @like_ramen_stores = current_user.like_ramen_stores.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def rank
    # @like_ids = Like.group(:ramen_store_id).order('count(ramen_store_id) desc').limit(10).pluck(:ramen_store_id)
    @store_likes_rank = RamenStore.joins(:likes).select('ramen_stores.*, count(ramen_stores.id) as likes_count').group(:id).order('likes_count desc').limit(10)
    @score_ids = RatingCache.order(avg: :desc).limit(20).pluck(:cacheable_id)
    @store_score_rank = RamenStore.find(@score_ids)
    # @review_ids = RamenStoreReview.group(:ramen_store_id).order('count(ramen_store_id) desc').limit(10).pluck(:ramen_store_id)
    # @review_rank = RamenStore.find(@review_ids)
    @review_rank = RamenStore.joins(:reviews).select('ramen_stores.*, count(ramen_stores.id) as reviews_count').group(:id).order('reviews_count desc').limit(10)
  end

  private

  def set_ramen_store
    @ramen_store = RamenStore.find(params[:id])
  end

  def ramen_store_params
    params.require(:ramen_store).permit(
      :name, :postcode, :prefecture_id, :city,
      :address, :building, :phone_number,
      :sale, :holiday, :seat, :access,
      :parking_space, :sns, :content,
      :tag_list,
      menus_attributes: %i[name price],
      registered_images_attributes: %i[id name image]
    )
  end
end
