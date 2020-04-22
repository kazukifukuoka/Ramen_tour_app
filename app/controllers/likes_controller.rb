class LikesController < ApplicationController
  def create
    @ramen_store = RamenStore.find(params[:ramen_store_id])
    @like = current_user.likes.create!(ramen_store_id: @ramen_store.id)
  end

  def destroy
    @ramen_store = RamenStore.find(params[:ramen_store_id])
    like = Like.find_by(user_id: current_user.id, ramen_store_id: @ramen_store.id)
    like.destroy!
  end
end
