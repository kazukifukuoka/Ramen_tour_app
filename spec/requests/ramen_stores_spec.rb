require 'rails_helper'

describe RamenStoresController, type: :request do

  # describe 'GET #index' do
  #   context '未ログインの場合' do
  #     example 'リクエスト失敗' do
  #       get ramen_stores_url
  #       expect(response).to redirect_to new_user_session_url
  #     end
  #   end

  #   context 'ログイン済みの場合' do
  #     login
  #     example 'リクエストが成功すること' do
  #       get ramen_stores_url
  #       expect(response.status).to eq(200)
  #     end

  #     context '店舗が投稿されていない場合'
  #       example '店舗投稿がまだありませんと表示' do
  #         get ramen_stores_url
  #         expect(response.body).to include '店舗投稿がまだありません'
  #       end


  #     context '店舗投稿がされている場合' do
  #       example '店舗の情報が表示されている' do
  #         create(:ramen_store)
  #         get ramen_stores_url
  #         expect(response.body).to include '店舗1'
  #         expect(response.body).to include 'いいね'
  #         expect(response.body).to include '投稿者'
  #         expect(response.body).to include 'テストタグ'
  #       end
  #     end
  #   end
  # end

  # describe 'GET #show' do
  #   context '未ログインユーザーの場合' do
  #     example 'リクエスト失敗' do
  #       @ramen_store = create(:ramen_store)
  #       get ramen_store_url @ramen_store.id
  #       expect(response).to redirect_to new_user_session_url
  #     end
  #   end

  #   context 'ログイン済みの場合' do
  #     login
  #     context '店舗が存在する場合' do
  #       before(:each) do
  #         @ramen_store = create(:ramen_store)
  #         get ramen_store_url @ramen_store.id
  #       end
  #       example 'リクエストが成功すること' do
  #       expect(response.status).to eq(200)
  #       end

  #       example '店舗の情報が表示されていること' do
  #         expect(response.body).to include '店舗'
  #         expect(response.body).to include '北海道'
  #         expect(response.body).to include 'A市B町'
  #         expect(response.body).to include 'Dビル101号室'
  #         expect(response.body).to include '0123-45-678'
  #         expect(response.body).to include '18時から20時まで'
  #         expect(response.body).to include '毎週月曜日'
  #         expect(response.body).to include 'カウンター20席'
  #         expect(response.body).to include '駅から6分'
  #         expect(response.body).to include '近くにパーキングエリア'
  #         expect(response.body).to include 'Twitter: @テスト'
  #         expect(response.body).to include 'テストです'
  #         expect(response.body).to include 'テストタグ'
  #     end
  #   end

  #     context '店舗が存在しない場合' do
  #       subject { -> { get ramen_store_url 100 } }

  #       it { is_expected.to raise_error ActiveRecord::RecordNotFound }
  #     end
  #   end
  # end

  # describe 'GET #new' do
  #   context '未ログインユーザーの場合' do
  #     example 'リクエスト失敗' do
  #       get new_ramen_store_url
  #       expect(response).to redirect_to new_user_session_url
  #     end
  #   end

  #   context 'ログイン済みの場合' do
  #     login
  #     example 'リクエストが成功すること' do
  #       get new_ramen_store_url
  #       expect(response.status).to eq(200)
  #     end
  #   end
  # end

  # describe 'GET #edit' do
  #   context '未ログインユーザーの場合' do
  #     example 'リクエスト失敗' do
  #       @ramen_store = create(:ramen_store)
  #       get new_ramen_store_url @ramen_store.id
  #       expect(response.status).to eq(401)
  #     end
  #   end

  #   context 'ログイン済みの場合' do
  #     login
  #     before(:each) do
  #       @ramen_store = create(:ramen_store)
  #       get new_ramen_store_url @ramen_store.id
  #     end
  #     context '店舗が存在する場合' do
  #       example 'リクエストが成功すること' do
  #         expect(response.status).to eq(200)
  #       end

        # example '店舗の情報が表示されていること' do
        #   expect(response.body).to include '店舗'
        #   expect(response.body).to include '北海道'
        #   expect(response.body).to include 'A市B町'
        #   expect(response.body).to include 'Dビル101号室'
        #   expect(response.body).to include '0123-45-678'
        #   expect(response.body).to include '18時から20時まで'
        #   expect(response.body).to include '毎週月曜日'
        #   expect(response.body).to include 'カウンター20席'
        #   expect(response.body).to include '駅から6分'
        #   expect(response.body).to include '近くにパーキングエリア'
        #   expect(response.body).to include 'Twitter: @テスト'
        #   expect(response.body).to include 'テストです'
        #   expect(response.body).to include 'テストタグ'
        # end
  #     end
  #   end
  # end

  describe 'POST #create' do
    login
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post ramen_stores_url, params: { ramen_store: attributes_for(:ramen_store) }
        expect(response.status).to eq(302)
      end

      it '店舗が登録されること' do
        expect do
          post ramen_stores_url, params: { ramen_store: attributes_for(:ramen_store) }
        end.to change(RamenStore, :count).by(1)
      end

      it 'リダイレクトすること' do
        post ramen_stores_url, params: { ramen_store: attributes_for(:ramen_store) }
        expect(response).to redirect_to ramen_stores_url
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post ramen_stores_url, params: { ramen_store: attributes_for(:ramen_store, :invalid) }
        expect(response.status).to eq(200)
      end

      # it '店舗が登録されないこと' do
      #   expect do
      #     post ramen_stores_url, params: { ramen_store: create(:ramen_store, :invalid) }
      #   end.to_not change(RamenStore, :count)
      # end

      # it 'エラーが表示されること' do
      #   post ramen_stores_url, params: { ramen_store: create(:ramen_store, name: '') }
      #   expect(response.body).to include '店舗登録に失敗しました'
      # end
    end
  end
end