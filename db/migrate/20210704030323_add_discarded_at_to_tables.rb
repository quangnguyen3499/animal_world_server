class AddDiscardedAtToTables < ActiveRecord::Migration[6.0]
  def change
    add_column :company_admins, :discarded_at, :datetime
    add_column :clients, :discarded_at, :datetime
    add_column :items, :discarded_at, :datetime

    add_index :company_admins, :discarded_at
    add_index :clients, :discarded_at
    add_index :items, :discarded_at
  end
end
