class User < ApplicationRecord
  has_and_belongs_to_many :conversations
  before_save :encode_password

  private

  def encode_password
    self.password = Authentication::CryptService.encode(password)
  end
end
