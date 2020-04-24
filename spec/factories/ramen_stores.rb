FactoryBot.define do
  factory :ramen_store do
    sequence(:name) { |n| "店舗#{n}" }
    postcode { '123-4567' }
    prefucture_id { '1' }
    city { 'A市B町' }
    address { 'C番地' }
    building { 'Dビル101号室' }
    sequence(:phonenumber) { |n| "123-45-678#{n}" }
    sale { '18時から20時まで' }
    holiday { '毎週月曜日' }
    seat { 'カウンター10席' }
    access { '駅から5分' }
    parking_space { '近くにパーキングエリア有り' }
    sns { 'Twitter: @テスト' }
    content{ 'テストです' }
    association :user
  end
end