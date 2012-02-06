class Authorization < ActiveRecord::Base
  belongs_to :created_by_api_key, :class_name => "ApiKey"
  has_one :registration
  has_one :user, :through => :registration

  validates_presence_of :code
  validates_uniqueness_of :code

  store :properties
end
