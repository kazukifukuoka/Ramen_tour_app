class RamenStore < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  belongs_to :user

  has_many :ramen_store_menus, dependent: :destroy
  has_many :ramen_store_user_images, dependent: :destroy
  accepts_nested_attributes_for :ramen_store_menus, allow_destroy: true
  accepts_nested_attributes_for :ramen_store_user_images, allow_destroy: true

  # VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/

  # validates :name, presence: true
  # validates :postcode, presence: true, numericality: { only_integer: true }
  # validates :prefecture_id, presence: true
  # validates :city, presence: true
  # validates :address, presence: true
  # validates :phone_number, presence: true, uniqueness: true, format: { with: VALID_PHONE_REGEX }
  # validates :sale, presence: true
  # validates :holiday, presence: true
  # validates :seat, presence: true
  # validates :access, presence: true
  # validates :parking_space, presence: true
  # validates :sns, presence: true
  # validates :content, presence: true
end
