class CreateDirections < ActiveRecord::Migration[6.0]
  def change
    create_table :directions do |t|
      t.integer :marker_id
      t.text :direct
    end

    add_index :directions, :marker_id
  end
end
