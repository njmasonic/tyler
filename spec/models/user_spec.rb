require 'spec_helper'

describe User do
  describe "#current_token" do
    let(:token) { mock_model(Token, token: 'abcd') }

    it "returns the last token when available" do
      user = User.create!(email: 'tom@smith.net', password: '1234')
      Token.stub(:find_last_by_user_id).with(user.id).and_return(token)
      user.current_token.should == token
    end
  end
end
