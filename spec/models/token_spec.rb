require 'spec_helper'

describe Token do
  let(:token) { Token.create!(user: mock_model(User)) }

  it { should belong_to(:user) }

  describe ".create!" do
    it "should generate a random token" do
      SecureRandom.stub(:urlsafe_base64).and_return('abcd')
      token.token.should == 'abcd'
    end
  end

  describe "#ensure_current!" do
    it "should generate a new token when expired" do
      old_token = token.token
      token.updated_at = 2.days.ago
      token.ensure_current!
      token.reload
      token.token.should_not == old_token
    end
  end

  describe "#expired?" do
    it "should be true if updated more than five minutes ago" do
      token.updated_at = 6.minutes.ago
      token.should be_expired
    end

    it "should be false if updated less than five minutes ago" do
      token.updated_at = 4.minutes.ago
      token.should_not be_expired
    end

    it "should be true if updated exactly five minutes ago" do
      token.updated_at = 5.minutes.ago
      token.should be_expired
    end
  end
end
