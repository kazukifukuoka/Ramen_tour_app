require 'rails_helper'

describe RamenStoresController, type: :controller do
  render_views
  let(:user) { build :user }
  let(:ramen_store) { build :ramen_store }

  describe 'GET #index' do
    before do
      login_user user
      get ramen_stores_path
    end

    context 'ログインしていないとき' do
      it 'ログインページに遷移' do
        redirect_to new_user_session_path
      end
    end
  end
end