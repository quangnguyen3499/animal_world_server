class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.string :name
      t.text :address
      t.string :tel
      t.string :url
      t.integer :floor
      t.integer :city_id
      t.text :description

      t.timestamps
    end
    add_index :places, :city_id
  end
end
