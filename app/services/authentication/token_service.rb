class Authentication::TokenService
  class << self
    def encode(data)
      JWT.encode data, secret_key, 'HS256'
    end

    def decode(data)
      begin
        JWT.decode(data, secret_key, true, { algorithm: 'HS256' }).first.symbolize_keys
      rescue
        false
      end
    end

    private

    def secret_key
      Rails.application.credentials.secret_key_base
    end
  end
end