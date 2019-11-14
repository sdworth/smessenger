class CreateUserConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :user_conversations do |t|
      t.belongs_to :user
      t.belongs_to :conversation

      t.timestamps
    end
  end
end
