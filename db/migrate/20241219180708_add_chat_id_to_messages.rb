class AddChatIdToMessages < ActiveRecord::Migration[7.2]
  def change
    add_column :messages, :chat_id, :integer
    add_index :messages, :chat_id
  end
end
