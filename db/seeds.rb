# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

RamenStore.destroy_all
User.destroy_all

HOLIDAY = ["毎週月曜日","毎週火曜日","毎週水曜日","毎週木曜日","毎週金曜日"]
PARKING_SPACE = ["有り", "無し", "近くにパーキングエリア多数", "徒歩圏内にパーキングエリア有り"]
SNS = ["無し", "有り"]
TAG_LIST = ["人気店", "駅近", "こってり", "あっさり", "広々空間", "SNSで話題", "ネギ入れ放題", "替え玉無料", "リーズナブル", "女性に人気", "１人でも入りやすい", "クーポンあり", "テレビで話題"]

User.find_or_create_by!(email: "seed@example.com") do |user|
  user.nickname = "seed_user"
  user.sex = "male"
  user.password = "password"
  user.image = File.open("./app/assets/images/guest_sample.png")
  user.confirmed_at = Time.now
end
user = User.find_by(email: "seed@example.com")
50.times do |n|
  RamenStore.create!(
    name: "店舗#{n + 1}",
    postcode: "112-#{format("%04d", rand(0..999))}",
    prefecture_id: "#{rand(1..47)}",
    city: "#{rand(1..500)}市",
    address: "#{rand(1..500)}番地",
    phone_number: "#{format("%04d", rand(0..999).to_s)}-66-#{format("%04d", rand(0..9999).to_s)}",
    sale: "#{rand(10..17)}時から#{rand(21..24)}時まで",
    holiday: "#{HOLIDAY[rand(0..4)]}",
    seat: "カウンター#{rand(8..12)}席、テーブル#{rand(3..6)}席",
    access: "駅から徒歩#{rand(1..20)}分",
    parking_space: "#{PARKING_SPACE[rand(0..3)]}",
    sns: "#{SNS[rand(0..1)]}",
    content: "テスト",
    user_id: user.id,
    tag_list: "#{TAG_LIST[rand(0..12)]},#{TAG_LIST[rand(0..12)]}"
  )
end

MENU = ["醤油ラーメン", "味噌ラーメン", "豚骨ラーメン", "まぜそば", "冷麺", "ピリ辛ラーメン"]
PRICE = [600, 700, 800, 900, 1000]
REGISTERED_IMAGE = ["./app/assets/images/IMG_3093.jpg", "./app/assets/images/IMG_3155.jpg", "./app/assets/images/IMG_3173.jpg", "./app/assets/images/f6c3687f78d58e7aa6aa24dbb5fb7711.jpg", "./app/assets/images/10724005418.jpg", "./app/assets/images/images.jpeg", "./app/assets/images/60a4235ac64a3009992eb0347228a771_t.jpeg"]
TITLE = ["美味しかったです", "また来たいです", "店員さんの愛想がよかったです", "ご馳走様でした", "注文してからで来るのが遅かった", "二度といきません", "一人でも通いやすい"]

RamenStore.all.each do |store|
  store.menus.create!(
    [
      {
        name: "#{MENU[rand(0..5)]}",
        price: "#{PRICE[rand(0..4)]}",
        ramen_store_id: store.id
      },
      {
        name: "#{MENU[rand(0..5)]}",
        price: "#{PRICE[rand(0..4)]}",
        ramen_store_id: store.id
      },
      {
        name: "#{MENU[rand(0..5)]}",
        price: "#{PRICE[rand(0..4)]}",
        ramen_store_id: store.id
      }
    ]
  )
  store.registered_images.create!(
    [
      {
        name: "#{MENU[rand(0..5)]}",
        image: File.open(REGISTERED_IMAGE[rand(0..6)]),
        ramen_store_id: store.id,
        user_id: user.id
      },
      {
        name: "#{MENU[rand(0..5)]}",
        image: File.open(REGISTERED_IMAGE[rand(0..6)]),
        ramen_store_id: store.id,
        user_id: user.id
      },
      {
        name: "#{MENU[rand(0..5)]}",
        image: File.open(REGISTERED_IMAGE[rand(0..6)]),
        ramen_store_id: store.id,
        user_id: user.id
      }
    ]
  )
  store.reviews.create!(
    [
      {
        title: "#{TITLE[rand(0..6)]}",
        content: "テストテストテストテストテストテストテストテストテストテストテストテストテストテストテスト",
        ramen_store_id: store.id,
        user_id: user.id,
        tag_list: "#{TAG_LIST[rand(0..12)]},#{TAG_LIST[rand(0..12)]}"
      },
      {
        title: "#{TITLE[rand(0..6)]}",
        content: "テストテストテストテストテストテストテストテストテストテストテストテストテストテストテスト",
        ramen_store_id: store.id,
        user_id: user.id,
        tag_list: "#{TAG_LIST[rand(0..12)]},#{TAG_LIST[rand(0..12)]}"
      },
      {
        title: "#{TITLE[rand(0..6)]}",
        content: "テストテストテストテストテストテストテストテストテストテストテストテストテストテストテスト",
        ramen_store_id: store.id,
        user_id: user.id,
        tag_list: "#{TAG_LIST[rand(0..12)]},#{TAG_LIST[rand(0..12)]}"
      }
    ]
  )
end
puts "成功"