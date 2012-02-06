require 'spec_helper'

describe Authorization do
  before { Authorization.create! code: '5678' }

  it { should belong_to(:created_by_api_key) }
  it { should have_one(:user).through(:registration) }
  it { should have_one(:registration) }
  it { should validate_uniqueness_of(:code) }
  it { should validate_presence_of(:code) }
end
