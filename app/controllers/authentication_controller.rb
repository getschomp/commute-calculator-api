class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
      authentication = Services::Authenticator.new(
        params[:email], params[:password]).call
      render json: { auth_token: authentication }
    rescue => e
      Rails.logger.warn(e)
      render json: { errors: [GENERIC_HUMANIZED_ERROR] }, status: :unauthorized
    end
  end

end
