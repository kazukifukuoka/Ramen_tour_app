require 'rails_helper'

RSpec.describe '共通系', type: :system do
  before do
    visit root_path
  end
  describe 'ヘッダー' do
    it 'ヘッダーが正しく表示されていること' do
      expect(page).to have_content('Ramen Tour'), 'ヘッダーに「掲示板」というテキストが表示されていません'
    end
  end
end