class Api::AuthorizationsController < ApplicationController
  respond_to :json

  def create
    api_key = ApiKey.find_by_key(params[:key])
    if api_key
      authorization = Authorization.create!(params[:authorization])
      render :json => authorization.to_json
    else
      render :json => nil, :status => :not_found
    end
  end
end
