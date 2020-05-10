class RamenStoreReviewImage < ApplicationRecord
  # belongs_to :ramen_store
  belongs_to :ramen_store_review

  mount_uploader :image, ImagesUploader
end
