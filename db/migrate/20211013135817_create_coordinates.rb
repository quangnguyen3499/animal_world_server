class CreateCoordinates < ActiveRecord::Migration[6.0]
  def change
    create_table :coordinates do |t|
      t.integer :shop_id
      t.bigint :longitude
      t.bigint :latitude
    end
    add_index :coordinates, :shop_id
  end
end
