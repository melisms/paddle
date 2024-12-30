class DropNotificationsTable < ActiveRecord::Migration[8.0] # Adjust version if needed
  def change
    drop_table :notifications, if_exists: true
  end
end
