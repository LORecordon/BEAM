class API::V1::APIKeysController < APIController
  include APIKeyAuthenticatable
  prepend_before_action :authenticate_with_api_key!, only: %i[index destroy]

  def index
    render json: current_bearer.api_keys
  end

  def create
    authenticate_with_http_basic do |email, password|
      user = User.find_by(email: email)

      if user.authenticate(password)
        api_key = user&.api_keys.create!(token: SecureRandom.hex)
        puts api_key

        render json: api_key, status: :created and return
      else
        render status: :unauthorized
      end
    end
  end

  def destroy
    api_key = current_bearer.api_keys.find(params[:id])
    api_key.destroy
  end

end
