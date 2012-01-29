class ApiKey < ActiveRecord::Base
  before_create :generate_key

  private

  def generate_key
    self.key = SecureRandom.urlsafe_base64(64)
  end
end
