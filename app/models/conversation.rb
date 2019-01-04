class Conversation < ApplicationRecord
  # Associations
  has_many :messages, dependent: :destroy
  has_and_belongs_to_many :users

  # Enums
  enum status: { private_conversation: 0, group_conversation: 1 }
end
