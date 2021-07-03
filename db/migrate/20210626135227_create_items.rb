class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :type
      t.string :name
      t.integer :updated_by
      
      t.timestamps
    end
  end
end
