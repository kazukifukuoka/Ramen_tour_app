class RamenStoresController < ApplicationController

  def top
  end

  def index
  end

  def new
    @ramen_store = RamenStore.new
  end

  def create
    @ramen_store = RamenStore.new(ramen_store_params)
    if @ramen_store.save
      flash[:success] = "ユーザを登録しました"
      redirect_to root_path
    else
      flash[:danger] = "ユーザの登録に失敗しました"
      render 'new'
    end
  end

  def show

  end

  private
    def ramen_store_params
      params.require(:ramen_store).permit(:name, :menu, :sale, :address, :parking_space, :phone_number, :sns, :prefecture, :content)
    end
end