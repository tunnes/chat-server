class Conversation < ApplicationRecord
  enum type: %i[private_conversation group_conversation]
  has_and_belongs_to_many :users
  has_many :messages, dependent: :destroy

end
