require 'spec_helper'

describe Api::AuthorizationsController do
  describe "#create", "with valid parameters" do
    let(:authorization) { mock_model(Authorization, save: true, to_json: 'mockjson') }
    let(:valid_api_key) { mock_model(ApiKey) }

    before do
      ApiKey.stub(:find_by_key).with('validapikey').and_return(valid_api_key)
      Authorization.stub(:create!).with('validparameters').and_return(authorization)
      post :create, key: 'validapikey', authorization: 'validparameters'
    end

    specify { response.code.should == '200' }
    specify { response.body.should == 'mockjson' }
  end

  describe "#create", "with invalid key" do
    before do
      ApiKey.stub(:find_by_key).with('invalidkey').and_return(nil)
      post :create, key: 'invalidkey', authorization: 'parameters'
    end

    specify { response.code.should == '404' }
  end
end
