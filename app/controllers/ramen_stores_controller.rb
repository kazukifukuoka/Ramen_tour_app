class RamenStoresController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_ramen_store, only: %i[show update destroy]

  PER = 10

  def top; end

  def index
    @ramen_stores = RamenStore.page(params[:page]).per(PER)
    return unless params[:tag_name]

    @ramen_stores = RamenStore.tagged_with(params[:tag_name].to_s)
    @ramen_stores = @ramen_stores.page(params[:page]).per(PER)
  end

  def new
    @ramen_store = RamenStore.new
    @ramen_store.menus.build
    2.times { @ramen_store.registered_images.build }
  end

  def show
  end

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
