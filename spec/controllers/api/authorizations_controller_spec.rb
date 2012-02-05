require 'spec_helper'

describe Api::AuthorizationsController do
  describe "#create", "with valid parameters" do
    let(:authorization) { mock_model(Authorization, save: true, to_json: 'mockjson') }
    let(:valid_api_key) { mock_model(ApiKey, id: 72) }

    before do
      post_parameters = 
      {
        'key'           => 'validapikey',
        'authorization' => 
        {
          'code' =>  '1234',
          'other' => 'othervalue' 
        }
      }
      create_parameters =
      {
        'code' => '1234',
        'created_by_api_key_id' => 72,
        'properties' => 
        {
          'other' => 'othervalue'
        }
      }
      ApiKey.stub(:find_by_key).with('validapikey').and_return(valid_api_key)
      Authorization.stub(:create!).with(create_parameters).and_return(authorization)
      post :create, post_parameters
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
