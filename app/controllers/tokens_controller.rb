class TokensController < ApplicationController
  def validate
    @token = Token.find_by_token(params[:token])
    if @token.nil? || @token.expired?
      render :json => nil, :status => :not_found
    else
      render :json => @token.to_json(
        :only => [:created_at],
        :include => [
          :user => { :only => [:email] }
        ]
      )
    end
  end
end
