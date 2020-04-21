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
  has_many :score, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  accepts_nested_attributes_for :menus, allow_destroy: true
  accepts_nested_attributes_for :registered_images, allow_destroy: true

  VALID_PHONE = /\A(((0(\d{1}[-]{1}\d{4}|\d{2}[-]{1}\d{3}|\d{3}[-]{1}\d{2}|\d{4}[-]{1}\d{1}|[5789]0[-]{1}\d{4})[-]{1})|\d{1,4}\-{1})\d{4}|0120[-]{1}\d{3}[-]{1}\d{3})\z/.freeze # rubocop:disable Layout/LineLength
  VALID_POSTCODE = /\A\d{3}-{1}\d{4}\z/.freeze
  VALID_TAG = /\A[^ 　]+(?:,.[^ 　]+)*\Z/.freeze

  validates :name, presence: true
  validates :postcode, presence: true, format: { with: VALID_POSTCODE }
  validates :prefecture_id, presence: true
  validates :city, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, uniqueness: true, format: { with: VALID_PHONE }
  validates :sale, presence: true
  validates :holiday, presence: true
  validates :seat, presence: true
  validates :access, presence: true
  validates :parking_space, presence: true
  validates :sns, presence: true
  validates :content, presence: true
  validates :tag_list, presence: true, format: { with: VALID_TAG }
end
