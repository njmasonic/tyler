class User < ActiveRecord::Base
  include Clearance::User

  def current_token
    Token.find_last_by_user_id(self.id)
  end
end
