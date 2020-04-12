class RamenStoreReview < ApplicationRecord
  belongs_to :ramen_store
  belongs_to :user
  has_many :images, class_name: "RamenStoreReviewImage", dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
end
