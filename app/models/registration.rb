class Registration < ActiveRecord::Base
  store :properties
  belongs_to :authorization
  belongs_to :user
  accepts_nested_attributes_for :user

  validate :check_properties, :on => :create

  def user
    super || build_user
  end

  def properties
    existing = super

    APP_CONFIG["registration_properties"].each do |property|
      existing[property] ||= ""
    end

    existing
  end

  private

  def check_properties
    # Lookup configured registration properties
    registration_properties = APP_CONFIG["registration_properties"]

    # Find the associated Authorization
    self.authorization = Authorization.find_by_code(code)

    # If an Authorization was found ensure that each registration property matches and record
    # whether or not it has been used by another user
    if authorization
      authorization_used = authorization.user.present?
      registration_valid = registration_properties.all? do |property|
        properties[property] == authorization.properties[property]
      end
    else
      registration_valid = false
    end

    # If the Authorization is unused and the registration properties match the authorization properties then
    # procceed without validation eror.
    if !registration_valid || authorization_used
      errors.add(:registration, "information is not valid or is associated with an existing user")
    end
  end
end
