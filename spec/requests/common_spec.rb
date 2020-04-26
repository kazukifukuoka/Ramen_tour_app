require 'rails_helper'

RSpec.describe '共通系', type: :request do

  describe 'ヘッダー' do
    context 'ログイン前' do
      example 'ヘッダーが正しく表示されていること' do
        get '/'
        expect(response.body).to include('Ramen Tour'), 'ヘッダーに「Ramen Tour」というテキストが表示されていません'
        expect(response.body).to include('かんたんログイン'), 'ヘッダーに「かんたんログイン」というテキストが表示されていません'
        expect(response.body).to include('ログイン'), 'ヘッダーに「ログイン」というテキストが表示されていません'
      end
    end

    context 'ログイン後' do
      login
      example 'ヘッダーが正しく表示されていること' do
        get '/'
        expect(response.body).to include('Ramen Tour'), 'ヘッダーに「Ramen Tour」というテキストが表示されていません'
        expect(response.body).to include('店舗登録'), 'ヘッダーに「店舗登録」というテキストが表示されていません'
        expect(response.body).to include('お気に入り'), 'ヘッダーに「お気に入り」というテキストが表示されていません'
        expect(response.body).to include('マイページ'), 'ヘッダーに「マイページ」というテキストが表示されていません'
        expect(response.body).to include('ログアウト'), 'ヘッダーに「ログアウト」というテキストが表示されていません'
      end
    end
  end
end