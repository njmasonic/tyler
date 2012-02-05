class Api::AuthorizationsController < ApplicationController
  respond_to :json
  skip_before_filter :verify_authenticity_token

  def create
    api_key = ApiKey.find_by_key(params[:key])
    if api_key
      authorization = Authorization.create!(params_for_authorization.merge('created_by_api_key_id' => api_key.id))
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
