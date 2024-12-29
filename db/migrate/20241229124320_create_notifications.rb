class CreateNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :notifications do |t|
      t.string :receiver_type, null: false  # Store type of receiver (e.g., User)
      t.bigint :receiver_id, null: false  # Store the receiver's ID (user ID)
      t.json :params  # Use json instead of jsonb for SQLite3
      t.datetime :read_at  # Mark when the notification was read
      t.timestamps
    end

    add_index :notifications, [:receiver_type, :receiver_id]
  end
end
