require 'spec_helper'

describe TokensController do
  describe "#validate" do
    let(:token) { mock_model(Token, token: '1234', to_json: 'mockjson') }

    before do
      Token.stub(:find_by_token).with('1234').and_return(token)
      get :validate, token: '1234'
    end

    it "should return json" do
      response.body.should == "mockjson"
    end
  end
end
