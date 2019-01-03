class Authentication::TokenService
  class << self
    def encode(data)
      JWT.encode data, ENV['JWT_SECRECT_KEY'], 'HS256'
    end

    def decode(data)
      begin
        JWT.decode(data, ENV['JWT_SECRECT_KEY'], true, { algorithm: 'HS256' }).first.symbolize_keys
      rescue
        false
      end
    end
  end
end