class Api::AuthorizationsController < ApplicationController
  respond_to :json

  def create
    api_key = ApiKey.find_by_key(params[:key])
    if api_key
      authorization = Authorization.create!(params_for_authorization)
      render :json => authorization.to_json
    else
      render :json => nil, :status => :not_found
    end
  end

  private

  def params_for_authorization
    other_properties = params[:authorization].reject { |k,v| k == 'code' }
    {
      'code' => params[:authorization][:code],
      'properties' => other_properties
    }
  end
end
