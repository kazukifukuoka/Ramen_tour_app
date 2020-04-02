class RamenStoresController < ApplicationController

  def top
  end

  def index
  end

  def new
    @ramen_store = RamenStore.new
    ramen_store_menu = @ramen_store.ramen_store_menus.build
  end

  def create
    @ramen_store = RamenStore.new(ramen_store_params)
    # @ramen_store_menu = @ramen_store.ramen_store_menus.build
    # binding.pry
    if @ramen_store.save
      flash[:success] = "店舗を登録しました"
      redirect_to root_path
    else
      flash[:danger] = "店舗の登録に失敗しました"
      render :new
    end
  end

  def show

  end

  private
    def ramen_store_params
      params.require(:ramen_store).permit(:name, :sale, :address, :parking_space, :phone_number, :sns, :content, :prefecture_id, ramen_store_menu_attributes:[:id, :name, :price])
    end
end