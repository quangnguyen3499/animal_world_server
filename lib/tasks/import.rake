# run `bundle exec rails import:data`
require 'database_cleaner'

namespace :import do
  desc "Import shop & coordinate from spreadsheet"
  task data: :environment do  
    puts "Clean shop & coordinate"
    Shop.delete_all
    Coordinate.delete_all
    
    puts 'Importing Shop & Coordinate'
    data = Roo::Spreadsheet.open('db/seed/coopmartDN.xlsx').sheet('floor_1')
    headers = data.row(1)
    data.each_with_index do |row, idx|
      next if idx == 0
      shop_data = Hash[[headers, row].transpose]
      if Shop.exists?(id: shop_data['id'])
        puts "Shop with id '#{shop_data['id']}' already exists"
        next
      end

      shop = Shop.new(shop_data.except("longitude", "latitude"))
      shop.save!
      Coordinate.create!(shop_id: shop.id, longitude: shop_data['longitude'], latitude: shop_data['latitude'])
    end
  end
end
