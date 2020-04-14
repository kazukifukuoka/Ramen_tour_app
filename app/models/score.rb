class Score < ApplicationRecord
  belongs_to :ramen_store
  belongs_to :ramen_store_review
end
