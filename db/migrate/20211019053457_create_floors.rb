class CreateFloors < ActiveRecord::Migration[6.0]
  def change
    create_table :floors do |t|
      t.integer :place_id
      t.string :name
    end

    add_index :floors, :place_id
  end
end
