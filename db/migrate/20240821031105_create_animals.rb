class CreateAnimals < ActiveRecord::Migration[7.2]
  def change
    create_table :animals do |t|
      t.string :name
      t.integer :age, null: false, default: 0
      t.boolean :adopted, null: false, default: false
      t.references :owner, null: true, foreign_key: true

      t.timestamps
    end
  end
end
