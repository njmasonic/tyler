class TokensController < ApplicationController
  def validate
    @token = Token.find_by_token(params[:token])
    if @token.nil? || @token.expired?
      render :json => nil, :status => :not_found
    else
      render :json => TokenSerializer.new(@token).to_json
    end
  end
end
