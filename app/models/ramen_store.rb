class RamenStore < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  has_many :ramen_store_menus

  validates :name, presence: true
  validates :sale, presence: true
  validates :address, presence: true
  validates :parking_space, presence: true
  validates :phone_number, presence: true, uniqueness: true
  validates :sns, presence: true
  validates :prefecture_id, presence: true
  validates :content, presence: true
end
