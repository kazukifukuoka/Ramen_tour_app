# require 'rails_helper'

# RSpec.describe 'ユーザー登録', type: :feature do

#   context '入力情報正常系' do
#     it 'ユーザーが新規作成できること' do
#       visit new_user_registration_path
# fill_in 'ニックネーム', with: 'テストユーザー'
# fill_in '性別', with: 'male'
# fill_in 'Eメール', with: 'example@example.com'
# fill_in 'パスワード', with: 'password'
# fill_in 'パスワード（確認用）', with: 'password'
# fill_in '自己紹介分', with: ' よろしくお願いします。'
# click_button 'アカウント登録'
#       expect(current_path).to eq login_path
#       # expect(current_path).to eq boards_path
#       expect(page).to have_content 'ユーザー登録が完了しました'
#     end
#   end

#   context '入力情報異常系' do
#     it 'ユーザーが新規作成できない' do
#       visit new_user_registration_path
#       fill_in 'メールアドレス', with: 'example@example.com'
#       click_button '登録'
#       expect(current_path).to eq '/users'
#       # expect(current_path).to eq boards_path
#       expect(page).to have_content 'ユーザー登録に失敗しました'
#       # 個別のエラーメッセージが表示されること
#       expect(page).to have_content '姓を入力してください'
#     end
#   end
# end
