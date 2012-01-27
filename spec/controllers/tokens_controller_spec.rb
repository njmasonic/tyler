require 'spec_helper'

describe TokensController do
  describe "#validate", "with a valid token" do
    let(:token) { mock_model(Token, token: '1234', to_json: 'mockjson', expired?: false) }

    before do
      Token.stub(:find_by_token).with('1234').and_return(token)
      get :validate, token: '1234'
    end

    it "should return json" do
      response.body.should == "mockjson"
    end
  end

  describe "#validate", "with an expired token" do
    let(:token) { mock_model(Token, token: '1234', expired?: true) }

    before do
      Token.stub(:find_by_token).with('1234').and_return(token)
      get :validate, token: '1234'
    end

    it "should return an error" do
      response.response_code.should == 404
    end
  end
end
