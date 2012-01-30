require 'spec_helper'

describe User do
  it "stores registration properties" do
    user = User.new
    user.registration_attributes = { testing: "123" }
    user.registration.testing.should == "123"
  end

  describe "when creating without registration properties configured" do
    it "is valid without any registration properties" do
      APP_CONFIG["registration_properties"] = []
      user = User.new
      user.email = "tom@smith.net"
      user.password = "mypassword"
      user.save.should be_true
    end
  end

  describe "when creating with registration properties configured" do
    let(:used_authorization) { mock_model(Authorization, code: "1234", zip: "56789", user: mock_model(User), properties: {"zip" => "56789"}) }
    let(:unused_authorization) { mock_model(Authorization, code: "1234", zip: "56789", user: nil, properties: {"zip" => "56789"}) }

    before do
      APP_CONFIG["registration_properties"] = ["code", "zip"]
    end

    it "is invalid if the registration code has already been used" do
      Authorization.stub(:find_by_code).with("1234").and_return(used_authorization)
      user = User.new
      user.email = "tom@smith.net"
      user.password = "mypassword"
      user.registration_attributes = { code: "1234", zip: "56789" }
      user.save.should be_false
      user.errors[:registration].should be_present
    end

    it "is invalid if the registration properties don't match the authorization properties" do
      Authorization.stub(:find_by_code).with("1234").and_return(unused_authorization)
      user = User.new
      user.email = "tom@smith.net"
      user.password = "mypassword"
      user.registration_attributes = { code: "1234", zip: "98765" }
      user.save.should be_false
      user.errors[:registration].should be_present
    end

    it "is invalid if the registration code isn't found in the authorization table" do
      Authorization.stub(:find_by_code).with("1234").and_return(nil)
      user = User.new
      user.email = "tom@smith.net"
      user.password = "mypassword"
      user.registration_attributes = { code: "1234", zip: "12345" }
      user.save.should be_false
      user.errors[:registration].should be_present
    end

    it "is valid if the registration properties match the authorization properties" do
      Authorization.stub(:find_by_code).with("1234").and_return(unused_authorization)
      user = User.new
      user.email = "tom@smith.net"
      user.password = "mypassword"
      user.registration_attributes = { code: "1234", zip: "56789" }
      user.valid?
      user.save.should be_true
    end
  end
end
