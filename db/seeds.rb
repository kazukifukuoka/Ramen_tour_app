# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

RamenStore.destroy_all
User.destroy_all
RatingCache.destroy_all
Rate.destroy_all

SEX = ["男性", "女性"]

HOLIDAY = ["毎週月曜日","毎週火曜日","毎週水曜日","毎週木曜日","毎週金曜日"]
PARKING_SPACE = ["有り", "無し", "近くにパーキングエリア多数", "徒歩圏内にパーキングエリア有り"]
SNS = ["無し", "有り"]
TAG_LIST = ["人気店", "駅近", "こってり", "あっさり", "広々空間", "SNSで話題", "ネギ入れ放題", "替え玉無料", "リーズナブル", "女性に人気", "１人でも入りやすい", "クーポンあり", "テレビで話題"]

MENU = ["醤油ラーメン", "味噌ラーメン", "豚骨ラーメン", "まぜそば", "冷麺", "ピリ辛ラーメン"]
PRICE = [600, 700, 800, 900, 1000]
REGISTERED_IMAGE = ["./app/assets/images/IMG_3093.jpg", "./app/assets/images/IMG_3155.jpg", "./app/assets/images/IMG_3173.jpg", "./app/assets/images/f6c3687f78d58e7aa6aa24dbb5fb7711.jpg", "./app/assets/images/10724005418.jpg", "./app/assets/images/images.jpeg", "./app/assets/images/60a4235ac64a3009992eb0347228a771_t.jpeg"]
TITLE = ["美味しかったです", "また来たいです", "店員さんの愛想がよかったです", "ご馳走様でした", "注文してからで来るのが遅かった", "二度といきません", "一人でも通いやすい"]

# 初期設定
users_number = 5 # ユーザー作成数
ramen_stores = 10

(users_number).times do |n|
  User.find_or_create_by!(email: "seed#{n + 1}@example.com") do |user|
    user.nickname = Faker::Name.name
    user.sex = SEX[rand(0..1)]
    user.password = "password"
    user.image = File.open(REGISTERED_IMAGE[rand(0..6)])
    user.confirmed_at = Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
  end
end
puts "ユーザー投入成功"

# 店舗登録
ramen_store_list = []
ramen_stores.times do |n|
  User.all.ids.shuffle.each do |user_id|
    ramen_store_list <<
      { name: "店舗#{user_id}",
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
        user_id: user_id,
        tag_list: "#{TAG_LIST[rand(0..12)]},#{TAG_LIST[rand(0..12)]}",
        created_at: Faker::Time.between(from: DateTime.now - 5, to: DateTime.now)
      }
  end
end
RamenStore.create!(ramen_store_list)
puts "店舗投入成功"

# 店舗のidとユーザーidが同じなら１〜５個のメニュー登録を行う
menus_list = []
User.all.ids.sort.each do |user_id|
  RamenStore.all.each do |ramen_store|
    if ramen_store.user_id == user_id
      rand(1..5).times do |n|
        menus_list <<
        { name: "#{MENU[rand(0..5)]}",
          price: "#{PRICE[rand(0..4)]}",
          ramen_store_id: ramen_store.id,
        }
      end
    end
  end
end
RamenStoreMenu.create!(menus_list)
puts "メニュー投入成功"

# 店舗のidとユーザーidが同じなら画像登録を１回行う
store_images_list = []
User.all.ids.sort.each do |user_id|
  RamenStore.all.each do |ramen_store|
    if ramen_store.user_id == user_id
        store_images_list <<
        { name: "#{MENU[rand(0..5)]}",
          image: File.open(REGISTERED_IMAGE[rand(0..6)]),
          ramen_store_id: ramen_store.id,
        }
    end
  end
end
RamenStoreUserImage.create!(store_images_list)
puts "店舗画像投稿成功"

# 店舗のidとユーザーidが異なるなら1/3の確率でいいねをする
likes_list = []
User.all.ids.sort.each do |user_id|
  RamenStore.all.each do |ramen_store|
    if ramen_store.user_id != user_id && rand(2) == 0
      likes_list <<
      { user_id: user_id,
        ramen_store_id: ramen_store.id
      }
    end
  end
end
Like.create!(likes_list)
puts "いいね投入成功"

# 店舗のidとユーザーidが異なるならレビューをする
reviews_list = []
review_images_list = []
n = 0
User.all.ids.sort.each do |user_id|
  RamenStore.all.each do |ramen_store|
    if ramen_store.user_id != user_id
      n += 1
        reviews_list <<
        { title: "#{TITLE[rand(0..6)]}",
          content: "テストテストテストテストテストテストテストテストテストテストテストテストテストテストテスト",
          ramen_store_id: ramen_store.id,
          user_id: user_id,
          tag_list: "#{TAG_LIST[rand(0..12)]},#{TAG_LIST[rand(0..12)]}",
          created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
        }
        review_images_list <<
        {
          name: "#{MENU[rand(0..5)]}",
          image: File.open(REGISTERED_IMAGE[rand(0..6)]),
          ramen_store_id: ramen_store.id,
          ramen_store_review_id: n
        }
    end
  end
end
RamenStoreReview.create!(reviews_list)
puts "レビュー投入成功"

# RamenStoreReview.all.ids.sort.each do |review_id|
#   RamenStore.all.each do |ramen_store|
#     ramen_store.reviews.each do |review|
#       if review.ramen_store_id == ramen_store.id
#           review_images_list <<
#           { name: "#{MENU[rand(0..5)]}",
#             image: File.open(REGISTERED_IMAGE[rand(0..6)]),
#             ramen_store_id: ramen_store.id,
#             ramen_store_review_id: review_id
#           }
#       end
#     end
#   end
# end
# RamenStore.all.ids.sort.each do |store_id|
#   RamenStoreReview.all.each do |review|
#     if review.ramen_store_id == store_id
#       review_images_list <<
#       { name: "#{MENU[rand(0..5)]}",
#         image: File.open(REGISTERED_IMAGE[rand(0..6)]),
#         ramen_store_id: store_id,
#         ramen_store_review_id: review.id
#       }
#     end
#   end
# end
RamenStoreReviewImage.create!(review_images_list)
puts "レビュー画像投稿成功"

rates_list = []
ramen_score_hash = {}
random = Random.new
User.all.ids.sort.each do |user_id|
  RamenStore.all.each do |ramen_store|
    if ramen_store.user_id != user_id
      random_star = rand(0..10)
      if ramen_score_hash.has_key?(ramen_store.id)
        ramen_score_hash[ramen_store.id] += random_star
      else
        ramen_score_hash[ramen_store.id] = random_star
      end
      rates_list <<
      { rater_id: user_id,               #レビューしたuser_id
        rateable_type: "RamenStore",     #ramen_storeテーブルにスコアをつける
        rateable_id: ramen_store.id,     #店舗のidを指定
        stars: random_star,               #評価した星の数
        dimension: "name",               #評価対象
      }
    end
  end
end

Rate.create!(rates_list)
puts "Rates投入成功"

# 店舗のidとユーザーidが異なるならスコア付をする
rating_cache_list = []
RamenStore.all.each do |ramen_store|
  rating_cache_list <<
  { cacheable_type: "RamenStore",    #ramen_storeテーブルにスコアをつける
    cacheable_id: ramen_store.id,    #店舗のidを指定
    avg: (ramen_score_hash[ramen_store.id] / (users_number.to_f- 1.0)).to_f,                          #０〜５の評価
    qty: users_number - 1,           #評価者の数(店舗登録者以外)
    dimension: "name"                #評価対象
  }
end

RatingCache.create!(rating_cache_list)
puts "Cache投入成功"
