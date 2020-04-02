class RamenStoreMenu < ApplicationRecord
  belongs_to :ramen_store

  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
end
