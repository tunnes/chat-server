class Conversation < ApplicationRecord
  enum status: { private_conversation: 0, group_conversation: 1 }
  has_and_belongs_to_many :users
  has_many :messages, dependent: :destroy

end
