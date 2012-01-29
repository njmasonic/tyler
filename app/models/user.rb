require 'ostruct'

class User < ActiveRecord::Base
  include Clearance::User

  def registration
    @registration ||= OpenStruct.new
  end

  def registration_attributes=(attributes)
    @registration = OpenStruct.new(attributes)
  end
end
