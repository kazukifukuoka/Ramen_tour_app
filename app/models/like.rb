class Like < ApplicationRecord
  belongs_to :user
  belongs_to :ramen_store
  validates :user_id, uniqueness: { scope: :ramen_store_id }
end
