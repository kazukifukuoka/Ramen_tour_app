FactoryBot.define do
  factory :ramen_store_user_image do
    name { 'テスト画像' }
    image { File.open("./app/assets/images/guest_sample.png") }
    created_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    association :user
  end
end