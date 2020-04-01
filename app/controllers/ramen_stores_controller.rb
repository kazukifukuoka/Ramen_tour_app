class RamenStoresController < ApplicationController

  def top
  end

  def index
  end

  def new
    @ramen = RamenStore.new
  end

  def create
    @ramen = RamenStore.new(ramen_params)
    if @ramen.save!
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    # @ramen = Ramen.find(params[:id])
  end

  private
    def ramen_params
      params.permit(:name, :menu, :sale, :address, :parking_space, :phone_number, :sns, :prefecture, :content)
    end
end