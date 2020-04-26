class RamenStoreMenu < ApplicationRecord
  belongs_to :ramen_store

  validates :name, presence: true, length: { maximum: 255 }
  validates :price, presence: true, numericality: { only_integer: true }
end
