require 'ostruct'

class User < ActiveRecord::Base
  include Clearance::User
end
