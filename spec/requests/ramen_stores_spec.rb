require 'rails_helper'

describe RamenStoresController, type: :request do
  # render_views
  # let(:user) { build (:user) }
  # let(:ramen_store) { build (:ramen_store) }

  describe 'GET #index' do
    context 'ログイン済みのユーザー' do
      login
      example 'リクエストが成功' do
        get ramen_stores_url
        expect(response).to have_http_status(:success)
      end

      context '店舗が投稿されていない時'
        example '店舗投稿がまだありませんと表示' do
          get ramen_stores_url
          expect(response.body).to include '店舗投稿がまだありません'
        end


      context '店舗投稿探されている時'
      let(:ramen_store) { create(:ramen_store) }
        example '店舗名が表示されている' do
          get ramen_stores_url
          expect(response.body).to include '店舗1'
        end
      end

    context '未ログインのユーザー' do
      example 'リクエスト失敗' do
        get ramen_stores_url
        expect(response).to have_http_status(302)
      end
    end

  end
end