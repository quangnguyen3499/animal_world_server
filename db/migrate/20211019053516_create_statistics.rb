class CreateStatistics < ActiveRecord::Migration[6.0]
  def change
    create_table :statistics do |t|
      t.integer :floor_id
      t.integer :place_id
      t.text :graph
    end

    add_index :statistics, :floor_id
    add_index :statistics, :place_id
  end
end
