class TokensController < ApplicationController
  def validate
    @token = Token.find_by_token(params[:token])
    render :json => @token.to_json(
      :only => [:created_at],
      :include => [
        :user => { :only => [:email] }
      ]
    )
  end
end
