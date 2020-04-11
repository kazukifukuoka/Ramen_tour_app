class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :ramen_stores, dependent: :destroy
  has_many :ramen_store_user_images, dependent: :destroy
  mount_uploader :image, ImagesUploader

  def is_confirmation_period_expired?
    # メールアドレス確認メール有効期限チェック(期限はconfig/initializers/devise.rbのconfirm_withinで設定)
    self.confirmation_period_expired?
  end

  def self.new_guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.nickname = "guest_user"
      user.sex = "male"
      user.password = "password"
      user.confirmed_at = Time.now
    end
  end
end
