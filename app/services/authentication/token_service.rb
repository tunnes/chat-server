module Authentication
  class TokenService
    class << self
      def encode(data)
        JWT.encode data, ENV['JWT_SECRECT_KEY'], 'HS256'
      end

      def decode(data)
        jwt_decode(data).first.symbolize_keys
      rescue
        false
      end

      private

      def jwt_decode(data)
        JWT.decode(data, ENV['JWT_SECRECT_KEY'], true, algorithm: 'HS256')
      end
    end
  end
end
