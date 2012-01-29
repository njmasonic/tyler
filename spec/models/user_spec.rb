require 'spec_helper'

describe User do
  it "stores registration properties" do
    user = User.new
    user.registration_attributes = { testing: "123" }
    user.registration.testing.should == "123"
  end
end
