class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  ratyrate_rater

  has_many :ramen_stores, dependent: :destroy
  has_many :ramen_store_user_images, dependent: :destroy
  has_many :ramen_store_reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_ramen_stores, through: :likes, source: :ramen_store

  mount_uploader :image, ImagesUploader

  validates :nickname, presence: true, length: { maximum: 10 }
  validates :sex, presence: true

  def is_confirmation_period_expired? # rubocop:disable Naming/PredicateName
    # メールアドレス確認メール有効期限チェック(期限はconfig/initializers/devise.rbのconfirm_withinで設定)
    confirmation_period_expired?
  end

  def self.new_guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.nickname = 'guest_user'
      user.sex = 'male'
      user.password = 'password'
      user.image = File.open('./app/assets/images/guest_sample.png')
      user.confirmed_at = Time.zone.now
    end
  end

  def own?(object)
    object.user_id == id
  end

  def already_like?(ramen_store)
    likes.exists?(ramen_store_id: ramen_store.id)
  end
end
