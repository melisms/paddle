class AddAgeToPets < ActiveRecord::Migration[8.0]
  def change
    add_column :pets, :age, :string
  end
end
