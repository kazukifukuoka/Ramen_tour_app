class RamenStoreUserImage < ApplicationRecord
  belongs_to :user
  belongs_to :ramen_store, optional: true

  mount_uploader :image, ImageUploader
end
