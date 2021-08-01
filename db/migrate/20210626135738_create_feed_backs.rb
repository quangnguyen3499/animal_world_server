class CreateFeedBacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feed_backs do |t|
      t.integer :client_id, :null => false
      t.integer :rating
      t.text :description

      t.timestamps
    end
    add_index :feed_backs, :client_id
  end
end
