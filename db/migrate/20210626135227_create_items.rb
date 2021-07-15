class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.integer :typical
      t.string :name
      t.integer :updated_by

      t.timestamps
    end
    add_index :items, :updated_by
  end
end
