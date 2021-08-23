class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.string :name
      t.text :address
      t.string :tel
      t.string :url
      t.float :rating
      t.integer :status
      t.float :longitude
      t.float :latitude
      t.text :description

      t.timestamps
    end
  end
end
