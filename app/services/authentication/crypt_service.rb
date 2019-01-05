module Authentication
  class CryptService
    class << self
      def encode(data)
        BCrypt::Password.create(data).to_s
      end

      def decode(hash, data)
        BCrypt::Password.new(hash) == data if hash.present? && data.present?
      end
    end
  end
end
