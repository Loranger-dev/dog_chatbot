class CreateDogs < ActiveRecord::Migration[8.1]
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :breed
      t.integer :age
      t.text :description
      t.references :user_id

      t.timestamps
    end
  end
end
