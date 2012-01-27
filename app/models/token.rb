class Token < ActiveRecord::Base
  belongs_to :user
  belongs_to :consumer

  before_create :generate_token

  def ensure_current!
    if updated_at < 5.minutes.ago
      generate_token
      save!
    end
  end

  def expired?
    updated_at < 5.minutes.ago
  end

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
end
