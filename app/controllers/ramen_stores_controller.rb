class RamenStoresController < ApplicationController

  def top
  end

  def index
    @ramen_stores = RamenStore.all
  end

  def new
    @ramen_store = RamenStore.new
    ramen_store_menu = @ramen_store.ramen_store_menus.build
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

  def show
    @ramen_store = RamneStore.find_by(params[:id])
  end

  private
    def ramen_store_params
      params.require(:ramen_store).permit(:name, :postcode, :prefecture_id, :city, :address, :building, :phone_number, :sale, :holiday, :seat, :access, :parking_space, :sns, :content, ramen_store_menus_attributes:[:id, :name, :price])
    end
end