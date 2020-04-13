# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |n|
  RamenStore.create!(
    name: "店舗#{n}",
    postcode: "112-857#{n}",
    prefecture_id: n,
    city: "#{n}市",
    address: "#{n}番地",
    phone_number: "0123-45-678#{n}",
    sale: "#{n}時から",
    holiday: "#{n}日",
    seat: "カウンター#{n}席",
    access: "駅から#{n}分",
    parking_space: "無し",
    sns: "無し",
    content: "テスト",
    user_id: "1"
    tag_list: "人気店,駅近"
  )
end