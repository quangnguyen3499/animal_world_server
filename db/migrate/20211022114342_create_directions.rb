class CreateDirections < ActiveRecord::Migration[6.0]
  def change
    create_table :directions do |t|
      t.integer :marker_id
      t.integer :floor_id
      t.integer :place_id
      t.text :direct
    end

    add_index :directions, :marker_id
    add_index :directions, :floor_id
    add_index :directions, :place_id
  end
end
