class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.integer :typical
      t.string :name
      t.bigint :price
      t.float :discount
      t.integer :status
      
      t.timestamps
    end
  end
end
