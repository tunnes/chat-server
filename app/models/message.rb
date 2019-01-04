class Message < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :conversation
end
