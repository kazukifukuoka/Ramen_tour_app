require 'rails_helper'

describe RamenStoresController, type: :request do
  # render_views
  # let(:user) { build (:user) }
  # let(:ramen_store) { build (:ramen_store) }

  describe 'GET #index' do
    # before do
    #   login_user
    #   get :index
    # end
    context '登録後のユーザー' do
      login
      it 'ログイン成功' do
        get '/ramen_stores'
        expect(response).to have_http_status(:success)
      end
    end

    context 'without authentication' do
      it 'return fail status' do
        get '/pages'
        expect(response).to have_http_status(302)
      end
    end

    # it "@ramen_storesが期待される値を持つ" do
    #   ramen_stores = create_list(:ramen_store, 3)
    #   get :index
    #   expect(assigns(:ramen_stores)).to match(ramen_stores.sort{|a, b| b.created_at <=> a.created_at })
    # end

    # it "renders the :index template" do
    #   get :index
    #   expect(response).to have_http_status(200)
    # end


    # context 'ログインしていないとき' do
    #   it 'ログインページに遷移' do
    #     redirect_to new_user_session_path
    #   end
    end
end