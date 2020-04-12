class RamenStoresController < ApplicationController

  before_action :authenticate_user!, except: %i[top index show]
  before_action :set_ramen_store, only: %i[show edit update destroy]

  def top
  end

  def index
    @ramen_stores = RamenStore.all
    if params[:tag_name]
      @ramen_stores = RamenStore.tagged_with("#{params[:tag_name]}")
    end
  end

  def new
    @ramen_store = RamenStore.new
    ramen_store_menu = @ramen_store.ramen_store_menus.build
    ramen_store_user_image = 2.times{@ramen_store.ramen_store_user_images.build}
  end

  def show
  end

  def create
    @ramen_store = RamenStore.new(ramen_store_params)
    @ramen_store.user_id = current_user.id
    @ramen_store.ramen_store_user_images.each do |store_user_image|
      store_user_image.user_id = current_user.id
    end

    if @ramen_store.save
      flash[:success] = "店舗を登録しました"
      redirect_to ramen_stores_path
    else
      flash[:danger] = "店舗の登録に失敗しました"
      render :new
    end
  end

  def edit
  end

  def update
    if @ramen_store.update(ramen_store_params)
      flash[:success] = "店舗を更新しました"
      redirect_to ramen_store_path(@ramen_store)
    else
      flash[:danger] = "店舗の更新に失敗しました"
      render :edit
    end
  end

  def destroy
    if @ramen_store.destroy
      flash[:success] = "店舗を削除しました"
      redirect_to ramen_stores_path
    else
      flash[:danger] = "店舗の削除に失敗しました"
      render :show
    end
  end

  private

    def set_ramen_store
      @ramen_store = RamenStore.find(params[:id])
    end

    def ramen_store_params
      params.require(:ramen_store).permit(:name, :postcode, :prefecture_id, :city, :address, :building, :phone_number, :sale, :holiday, :seat, :access, :parking_space, :sns, :content, :tag_list, ramen_store_menus_attributes:[:name, :price], ramen_store_user_images_attributes:[:id, :name, :image])
    end
end