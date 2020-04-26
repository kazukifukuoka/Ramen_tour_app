module AuthenticationMacros
  def login
    let(:user) { build(:user) }
    before do
    user.confirm
    sign_in user
    end
  end
end