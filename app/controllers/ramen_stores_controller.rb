class RamenStoresController < ApplicationController

  def top
  end

  def index
  end

  def new
    @ramen = Ramen.new
  end

  def create
    @ramen = Ramen.new(ramen_params)
    if @ramen.save
      redirect_to root_path
    else
      render ramens_new_path
    end
  end

  def show
    # @ramen = Ramen.find(params[:id])
  end

  private
    def ramen_params
      params.require(:ramen).permit(:name, :menu, :sale, :address, :parking_space, :phone_number, :sns, :prefecture, :content)
    end
end