class LikesController < ApplicationController
  def create
    @like = current_user.likes.create(ramen_store_id: params[:ramen_store_id])
    @likes = Like.where(ramen_store_id: params[:ramen_store_id])
    @ramen_stores = RamenStore.all
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, ramen_store_id: params[:ramen_store_id])
    like.destroy
    @likes = Like.where(ramen_store_id: params[:ramen_store_id])
    @ramen_stores = RamenStore.all
  end
end