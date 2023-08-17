class APIController < ActionController::API
  include APIKeyAuthenticatable
  before_action :authenticate_with_api_key!
end
