class AddProfileDescriptionToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :profile_description, :text
  end
end
