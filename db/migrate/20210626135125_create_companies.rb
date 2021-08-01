class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.string :postcode
      t.string :tel
      t.string :url
      t.string :ranking
      t.text :description

      t.timestamps
    end
  end
end
