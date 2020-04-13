class RamenStoreReviewsController < ApplicationController

  before_action :set_ramen_store, only: %i[create show update destroy]
  before_action :set_ramen_store_review, only: %i[show edit update destroy]

  def new
    @ramen_store_review = RamenStoreReview.new
    @ramen_store_review_image = @ramen_store_review.images.build
  end

  def create
    @ramen_store_review = @ramen_store.reviews.build(review_params)
    @ramen_store_review.user_id = current_user.id
    @ramen_store_review.images.each do |review_image|
      review_image.ramen_store_id = @ramen_store.id
    end

    if @ramen_store_review.save
      flash[:notice] = "レビューを投稿しました"
      redirect_to ramen_store_path(@ramen_store)
    else
      flash[:danger] = "レビュー投稿に失敗しました"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @ramen_store_review.update(review_params)
      flash[:notice] = "レビューを編集しました"
      redirect_to ramen_store_review_path(@ramen_store, @ramen_store_review)
    else
      flash[:danger] = "レビューの編集に失敗しました"
      render :edit
    end
  end

  def destroy
    if @ramen_store_review.destroy
      flash[:success] = "レビューを削除しました"
      redirect_to ramen_store_path(@ramen_store)
    else
      flash[:danger] = "レビューの削除に失敗しました"
      render :show
    end
  end

  private
    def set_ramen_store
      @ramen_store = RamenStore.find(params[:ramen_store_id])
    end

    def set_ramen_store_review
      @ramen_store_review = RamenStoreReview.find(params[:id])
    end

    def review_params
      params.require(:ramen_store_review).permit(:title, :content, :tag_list,  images_attributes:[:id, :name, :image])
    end
end

