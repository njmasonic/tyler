require 'ostruct'

class User < ActiveRecord::Base
  include Clearance::User

  validate :check_registration, on: :create

  def registration
    @registration ||= OpenStruct.new
  end

  def registration_attributes=(attributes)
    @registration = OpenStruct.new(attributes)
  end

  private

  def check_registration
    # TODO: Move registration logic out of User model
    # Lookup configured registration properties and return if there aren't any (anyone can register)
    registration_properties = APP_CONFIG["registration_properties"]
    return if registration_properties.empty?

    # If a registration code is present then find the associated Authorization
    if registration.code.present?
      authorization = Authorization.find_by_code(registration.code)
    end

    # If an Authorization was found ensure that each registration property matches and record
    # whether or not it has been used by another user
    if authorization
      authorization_used = authorization.user.present?
      registration_valid = registration_properties.all? do |property|
        if property == "code"
          registration.code == authorization.code
        else
          registration.send(property) == authorization.properties[property]
        end
      end
    else
      registration_valid = false
    end

    # If the Authorization is unused and the registration properties match the authorization properties then
    # procceed without validation eror.
    # TODO: Record that an Authorization has been used
    if authorization_used || !registration_valid
      errors.add(:registration, "information is not valid or is associated with an existing user")
    end
  end
end
