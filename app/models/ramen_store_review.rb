class RamenStoreReview < ApplicationRecord
  acts_as_taggable
  belongs_to :ramen_store
  belongs_to :user
  has_many :images, class_name: 'RamenStoreReviewImage', dependent: :destroy
  has_many :score, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  VALID_TAG_REGEX = /\A[^ 　]+(?:,.[^ 　]+)*\Z/.freeze

  validates :title, presence: true
  validates :content, presence: true
  validates :tag_list, presence: true, format: { with: VALID_TAG_REGEX }
end
