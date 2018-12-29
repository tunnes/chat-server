class CreateConversationsUsers < ActiveRecord::Migration[5.2]
  def self.up
    create_table :conversations_users do |t|
      t.references :conversation, :user
    end
  end

  def self.down
    drop_table :conversations_users
  end
end
