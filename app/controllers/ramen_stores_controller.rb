class RamenStoresController < ApplicationController

  def top
  end

  def index
    @ramen_stores = RamenStore.all
  end

  def new
    @ramen_store = RamenStore.new
    ramen_store_menu = @ramen_store.ramen_store_menus.build
    ramen_store_user_image = @ramen_store.ramen_store_user_images.build
  end

  def show
    @ramen_store = RamenStore.find(params[:id])
  end

  def create
    @ramen_store = RamenStore.new(ramen_store_params)
    if @ramen_store.save
      flash[:success] = "店舗を登録しました"
      redirect_to root_path
    else
      flash[:danger] = "店舗の登録に失敗しました"
      render :new
    end
  end

  def edit
    @ramen_store = RamenStore.find(params[:id])
  end

  def update
    @ramen_store = RamenStore.find(params[:id])
    if @ramen_store.update(ramen_store_params)
      flash[:success] = "店舗を更新しました"
      redirect_to ramen_store_path(@ramen_store)
    else
      flash[:danger] = "店舗の更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @ramen_store = RamenStore.find(params[:id])
    if @ramen_store.destroy
      flash[:success] = "店舗を削除しました"
      redirect_to ramen_stores_path
    else
      flash[:danger] = "店舗の削除に失敗しました"
      render :show
    end
  end


  private
    def ramen_store_params
      params.require(:ramen_store).permit(:name, :postcode, :prefecture_id, :city, :address, :building, :phone_number, :sale, :holiday, :seat, :access, :parking_space, :sns, :content, ramen_store_menus_attributes:[:id, :name, :price], ramen_store_user_images_attributes:[:name, { images: [] }])
    end
end