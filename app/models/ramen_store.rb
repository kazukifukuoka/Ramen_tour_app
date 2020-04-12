class RamenStore < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  acts_as_taggable

  belongs_to :user

  has_many :ramen_store_menus, dependent: :destroy
  has_many :ramen_store_user_images, dependent: :destroy
  has_many :reviews, class_name: 'RamenStoreReview', dependent: :destroy
  has_many :images, class_name: 'RamenStoreReviewImage', dependent: :destroy
  accepts_nested_attributes_for :ramen_store_menus, allow_destroy: true
  accepts_nested_attributes_for :ramen_store_user_images, allow_destroy: true

  VALID_PHONE_REGEX = /\A(((0(\d{1}[-]{1}\d{4}|\d{2}[-]{1}\d{3}|\d{3}[-]{1}\d{2}|\d{4}[-]{1}\d{1}|[5789]0[-]{1}\d{4})[-]{1})|\d{1,4}\-{1})\d{4}|0120[-]{1}\d{3}[-]{1}\d{3})\z/
  VALID_POSTCODE_REGEX = /\A\d{3}-{1}\d{4}\z/
  VALID_TAG_REGEX = /\A[^ 　]+(?:,.[^ 　]+)*\Z/

  validates :name, presence: true
  validates :postcode, presence: true, format: { with: VALID_POSTCODE_REGEX }
  validates :prefecture_id, presence: true
  validates :city, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, uniqueness: true, format: { with: VALID_PHONE_REGEX }
  validates :sale, presence: true
  validates :holiday, presence: true
  validates :seat, presence: true
  validates :access, presence: true
  validates :parking_space, presence: true
  validates :sns, presence: true
  validates :content, presence: true
  validates :tag_list, presence: true, format: { with: VALID_TAG_REGEX }
end
