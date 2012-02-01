class Authorization < ActiveRecord::Base
  belongs_to :created_by_api_key, :class_name => "ApiKey"
  has_one :registration
  has_one :user, :through => :registration

  store :properties
end
