class CreateAnimals < ActiveRecord::Migration[6.0]
  def change
    create_table :animals do |t|
      t.integer :typical
      t.string :name
      t.text :description
      t.integer :quantity
      
      t.timestamps
    end
  end
end
