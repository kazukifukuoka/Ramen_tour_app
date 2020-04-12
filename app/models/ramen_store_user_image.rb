class RamenStoreUserImage < ApplicationRecord
  belongs_to :user
  belongs_to :ramen_store
  mount_uploader :image, ImagesUploader
end
