class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.string :name
      t.text :address
      t.string :tel
      t.string :url
      t.integer :floor
      t.text :description

      t.timestamps
    end
  end
end
