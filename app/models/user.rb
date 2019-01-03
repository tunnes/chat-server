class User < ApplicationRecord
  has_and_belongs_to_many :conversations
  before_save :encode_password

  # Validations
  validates :full_name, :user_name, :password, presence: true

  private

  def encode_password
    self.password = Authentication::CryptService.encode(password)
  end
end
