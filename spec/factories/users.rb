FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { '12345678' }
    nickname { Faker::Name.name }
    sex { 'male' }
    image { File.open('./app/assets/images/guest_sample.png') }
    profile { Faker::String.random }
  end
end