require 'spec_helper'

describe ApiKey do
  let(:api_key) { ApiKey.create! }

  describe ".create!" do
    it "should generate a random key" do
      SecureRandom.stub(:urlsafe_base64).with(64).and_return('abcd')
      api_key.key.should == 'abcd'
    end
  end
end
