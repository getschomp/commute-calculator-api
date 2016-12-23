module Services
  class RequestAuthorizor

    def initialize(headers = {})
      @headers = headers
      @errors = []
    end

    def call
      user
    end

    private

    attr_reader :headers, :errors

    def user
      @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
      @user || errors.push(:token, 'Invalid token') && nil
    end

    def decoded_auth_token
      @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
    end

    def http_auth_header
      if headers['Authorization'].present?
        return headers['Authorization'].split(' ').last
      else
        errors.push(:token, 'Missing token')
      end
      nil
    end
  end
end
