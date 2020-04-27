module AuthenticationMacros
  def login
    let(:user) { create(:user) }
    before do
    user.confirm
    sign_in user
    end
  end
end