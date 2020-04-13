class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :ramen_stores
  has_many :ramen_store_user_images
  has_many :ramen_store_reviews
  mount_uploader :image, ImagesUploader

  validates :nickname, presence: true, length: { maximum: 10 }
  validates :sex, presence: true

  def is_confirmation_period_expired?
    # メールアドレス確認メール有効期限チェック(期限はconfig/initializers/devise.rbのconfirm_withinで設定)
    self.confirmation_period_expired?
  end

  def self.new_guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.nickname = "guest_user"
      user.sex = "male"
      user.password = "password"
      user.image = File.open("./app/assets/images/guest_sample.png")
      user.confirmed_at = Time.now
    end
  end
end
