class TokenSerializer
  def initialize(token)
    @token = token
  end

  def to_json
    @token.to_json(
      :only => [:created_at, :updated_at],
      :include => [
        :user => { :only => [:email] }
      ]
    )
  end
end
