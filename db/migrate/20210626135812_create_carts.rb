class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.integer :client_id, :null => false
      t.integer :status

      t.timestamps
    end
    add_index :carts, :client_id
  end
end
