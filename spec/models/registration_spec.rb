require 'spec_helper'

describe Registration do
  it { should belong_to(:user) }

  describe "#user" do
    let(:user) { mock_model(User) }

    it "is a new user when Registration is new" do
      User.stub(:new).and_return(user)
      registration = Registration.new
      registration.user.should == user
    end
  end

  describe "#properties" do
    it { should serialize(:properties).as(Hash) }

    it "should build default properties when Registration is new" do
      APP_CONFIG["registration_properties"] = ["name", "zip_code"]
      registration = Registration.new
      registration.properties.should == { "name" => "", "zip_code" => "" }
    end
  end

  describe "#authorization" do
    let(:unused_authorization) { mock_model(Authorization, user: nil) }
    let(:used_authorization) { mock_model(Authorization, user: mock_model(User)) }

    it { should belong_to(:authorization) }

    it "is set after creation" do
      APP_CONFIG["registration_properties"] = []
      Authorization.stub(:find_by_code).with("1234").and_return(unused_authorization)
      registration = Registration.create! code: "1234"
      registration.authorization.should == unused_authorization
    end

    it "invalidates the Registration if the related Authorization has already been used" do
      APP_CONFIG["registration_properties"] = []
      Authorization.stub(:find_by_code).with("1234").and_return(used_authorization)
      registration = Registration.new code: "1234"
      registration.should_not be_valid
      registration.authorization.should == used_authorization
    end
  end
end
