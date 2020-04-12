class RamenStoreReviewsController < ApplicationController

  def new
    @ramen_store_review = RamenStoreReview.new
    @ramen_store_review_image = RamenStoreReviewImage.new
  end

  def create
    @ramen_store = RamenStore.find(params[:ramen_store_id])
    @ramen_store_review = @ramen_store.reviews.build(review_params)
    @ramen_store_review.user_id = current_user.id
    if @ramen_store_review.save
      flash[:notice] = "レビューを投稿しました"
      redirect_to ramen_store_path(@ramen_store)
    else
      flash[:danger] = "レビュー投稿に失敗しました"
      render :new
    end
  end

  def show
    @ramen_store_review = RamenStoreReview.find(params[:id])
  end

  private
    def review_params
      params.require(:ramen_store_review).permit(:title, :content, ramen_store_review_images_attributes:[:id, :name, :image])
    end
end

