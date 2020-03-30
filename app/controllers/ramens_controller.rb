class RamensController < ApplicationController

  def top
  end

  def index
  end

  def show
    @ramen = Ramen.find(params[:id])
  end

end