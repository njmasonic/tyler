require 'spec_helper'

describe Token do
  it { should belong_to(:user) }

  describe ".create!" do
    it "should generate a random token" do
      SecureRandom.stub(:urlsafe_base64).and_return('abcd')
      token = Token.create! user: mock_model(User)
      token.token.should == 'abcd'
    end
  end
end
