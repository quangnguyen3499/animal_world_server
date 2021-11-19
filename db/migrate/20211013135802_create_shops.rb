class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.string :name
      t.text :description
      t.integer :category_id
      t.integer :place_id
      t.integer :floor_id
    end

    add_index :shops, :place_id
    add_index :shops, :floor_id
    add_index :shops, :category_id
  end
end
