module Services
  class Authenticator

    attr_reader :errors

    def initialize(email, password)
      @email = email
      @password = password
      @errors = []
    end

    def call
      user ? JsonWebToken.encode(user_id: user.id) : GENERIC_HUMANIZED_ERROR
    end

    private

    attr_accessor :email, :password, :errors

    def user
      user = User.where(email: email).first
      return user if user && user.authenticate(password)

      errors.push :user_authentication, 'invalid credentials'
      nil
    end
  end
end
