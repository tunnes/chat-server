class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.column :access_type, :integer, default: 0
      t.string :title

      t.timestamps
    end
  end
end
