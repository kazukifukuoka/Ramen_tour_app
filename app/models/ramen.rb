class Ramen < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :menu, presence: true
  validates :sale, presence: true
  validates :address, presence: true
  validates :parking_space, presence: true
  validates :phone_number, presence: true, uniqueness: true
  validates :sns, presence: true
  validates :prefecture, presence: true
  validates :content, presence: true
end
