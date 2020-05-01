class RamenStoresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ramen_store, only: %i[show update destroy]
  before_action :request_path

  def top; end

  def index
    @q = RamenStore.ransack(params[:q])
    @ramen_stores = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
    return unless params[:tag_name]

    @ramen_stores = RamenStore.tagged_with(params[:tag_name].to_s).page(params[:page])

    submit_name_ids = RamenStore.where("submit_name = ?", params[:pref]) .pluck(:id)
    @submit_searched = RamenStore.where("submit_id IN (?) or submit_id IN (?)", submit_name_ids)
  end

  def new
    @ramen_store = RamenStore.new
    @ramen_store.menus.build
    # 2.times { @ramen_store.registered_images.build }
    @ramen_store.registered_images.build
  end

  def create
    @ramen_store = RamenStore.new(ramen_store_params)
    @ramen_store.user = current_user
    @ramen_store.registered_images.each do |registered_image|
      registered_image.user = current_user
    end

    if @ramen_store.save
      redirect_to ramen_stores_path, success: '店舗を登録しました'
    else
      flash[:danger] = '店舗の登録に失敗しました'
      render :new
    end
  end

  def show; end

  def edit
    @ramen_store = RamenStore.find_by(id: params[:id], user_id: current_user.id)
    unless @ramen_store
      flash[:danger] = '投稿者のみ編集できます'
      redirect_to ramen_store_path(params[:id])
    end
  end

  def update
    @ramen_store = current_user.ramen_stores.find(params[:id])
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
    @q = current_user.like_ramen_stores.ransack(params[:q])
    @like_ramen_stores = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
    return unless params[:tag_name]

    @like_ramen_stores = current_user.like_ramen_stores.tagged_with(params[:tag_name].to_s).page(params[:page])
  end

  def rank
    @store_likes_rank = RamenStore.joins(:likes).select('ramen_stores.*, count(ramen_stores.id) as likes_count').group(:id).order('likes_count desc').limit(15)
    @score_ids = RatingCache.order(avg: :desc).limit(15).pluck(:cacheable_id)
    @store_score_rank = RamenStore.find(@score_ids)
    @review_rank = RamenStore.joins(:reviews).select('ramen_stores.*, count(ramen_stores.id) as reviews_count').group(:id).order('reviews_count desc').limit(15)
  end

  def search
    @q = RamenStore.ransack(params[:q])
    @ramen_stores = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
    return unless params[:tag_name]

    @ramen_stores = RamenStore.tagged_with(params[:tag_name].to_s).page(params[:page])

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
      menus_attributes: %i[id name price _destroy],
      registered_images_attributes: %i[id name image _destroy]
    )
  end

  def request_path
    @path = controller_path + '#' + action_name
    def @path.is(*str)
      str.map { |s| include?(s) }.include?(true)
    end
  end

  def self.search(search)
    return RamenStore.all unless search
    RamenStore.where(['content LIKE ?', "%#{search}%"])
  end
end
