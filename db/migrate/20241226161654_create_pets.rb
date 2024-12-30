class CreatePets < ActiveRecord::Migration[8.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :location
      t.string :pet_type
      t.string :breed
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
