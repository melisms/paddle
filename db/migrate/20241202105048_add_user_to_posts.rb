class AddUserToPosts < ActiveRecord::Migration[7.2]
  def change
    unless column_exists?(:posts, :user_id)
      add_column :posts, :user_id, :integer, null: false
    end

    unless foreign_key_exists?(:posts, :users)
      add_foreign_key :posts, :users
    end

    unless index_exists?(:posts, :user_id)
      add_index :posts, :user_id
    end
  end
end
