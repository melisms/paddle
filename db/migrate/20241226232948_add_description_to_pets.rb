class AddDescriptionToPets < ActiveRecord::Migration[8.0]
  def change
    add_column :pets, :description, :text
  end
end
