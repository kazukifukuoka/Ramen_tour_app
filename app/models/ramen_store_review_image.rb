class RamenStoreReviewImage < ApplicationRecord
  belongs_to :ramen_store
  belongs_to :ramen_store_review, optional: true

  mount_uploader :image, ImagesUploader
end
