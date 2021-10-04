class AddDiscardedAtToTables < ActiveRecord::Migration[6.0]
  def change
    add_column :places, :discarded_at, :datetime
    add_column :users, :discarded_at, :datetime
    add_column :animals, :discarded_at, :datetime

    add_index :places, :discarded_at
    add_index :users, :discarded_at
    add_index :animals, :discarded_at
  end
end
