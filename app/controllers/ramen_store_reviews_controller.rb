class RamenStoreReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ramen_store, only: %i[new create show edit update destroy]
  before_action :set_ramen_store_review, only: %i[show edit update destroy]


  def new
    return redirect_back fallback_location: root_path, warning: '既にレビューを投稿しています' if RamenStoreReview.find_by(user_id: current_user.id)
    @ramen_store_review = @ramen_store.reviews.build
    @ramen_store_review.images.build
  end

  def create
    @ramen_store_review = @ramen_store.reviews.build(review_params)
    @ramen_store_review.user_id = current_user.id
    if @ramen_store_review.save
      redirect_to ramen_store_path(@ramen_store), success: 'レビューを投稿しました'
    else
      flash[:danger] = 'レビュー投稿に失敗しました'
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @ramen_store_review.update(review_params)
      flash[:notice] = 'レビューを編集しました'
      redirect_to ramen_store_review_path(@ramen_store, @ramen_store_review)
    else
      flash[:danger] = 'レビューの編集に失敗しました'
      render :edit
    end
  end

  def destroy
    redirect_back fallback_location: root_path, success: 'レビューを削除しました' if @ramen_store_review.destroy!
  end

  private

  def set_ramen_store
    @ramen_store = RamenStore.find(params[:ramen_store_id])
  end

  def set_ramen_store_review
    @ramen_store_review = @ramen_store.reviews.find(params[:id])
  end

  def review_params
    params.require(:ramen_store_review).permit(
      :title, :content, :tag_list,
      images_attributes: %i[id name image _destroy]
    )
  end
end
