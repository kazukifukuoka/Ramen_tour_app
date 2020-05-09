class RamenStore < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  acts_as_taggable
  ratyrate_rateable 'name'
  belongs_to_active_hash :prefecture
  belongs_to :user
  has_many :menus, class_name: 'RamenStoreMenu', dependent: :destroy
  has_many :registered_images, class_name: 'RamenStoreUserImage', dependent: :destroy
  has_many :reviews, class_name: 'RamenStoreReview', dependent: :destroy
  has_many :images, class_name: 'RamenStoreReviewImage', dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user

  accepts_nested_attributes_for :menus, allow_destroy: true
  accepts_nested_attributes_for :registered_images, allow_destroy: true

  ransack_alias :ramen_store, :name_or_city_or_address_or_phone_number_or_sale_or_holiday_or_seat_or_access_or_parking_space_or_sns_or_content
  # ransack_alias :store_pref, :prefecture_id_eq_content
  ransack_alias :store_address, :city_or_address_or_content

  VALID_PHONE = /\A(((0(\d{1}[-]{1}\d{4}|\d{2}[-]{1}\d{3}|\d{3}[-]{1}\d{2}|\d{4}[-]{1}\d{1}|[5789]0[-]{1}\d{4})[-]{1})|\d{1,4}\-{1})\d{4}|0120[-]{1}\d{3}[-]{1}\d{3})\z/.freeze # rubocop:disable Layout/LineLength
  VALID_POSTCODE = /\A\d{3}-{1}\d{4}\z/.freeze
  VALID_TAG = /\A[^ 　]+(?:,.[^ 　]+)*\Z/.freeze

  validates :name, presence: true, length: { maximum: 255 }
  validates :postcode, presence: true, format: { with: VALID_POSTCODE }
  validates :prefecture_id, presence: true
  validates :city, presence: true, length: { maximum: 255 }
  validates :address, presence: true, length: { maximum: 255 }
  validates :phone_number, presence: true, uniqueness: { case_sensitive: true }, format: { with: VALID_PHONE }
  validates :sale, presence: true, length: { maximum: 255 }
  validates :holiday, presence: true, length: { maximum: 255 }
  validates :seat, presence: true, length: { maximum: 255 }
  validates :access, presence: true, length: { maximum: 255 }
  validates :parking_space, presence: true, length: { maximum: 255 }
  validates :sns, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 65_535 }
  validates :tag_list, presence: true, format: { with: VALID_TAG }
end
