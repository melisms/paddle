class ChangeRoleColumnTypeInUsers < ActiveRecord::Migration[7.2]
  def change
    # Change role column from string to integer
    change_column :users, :role, :integer, default: 0, null: false
  end
end
