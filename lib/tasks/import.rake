namespace :import do
  desc "Import shops from spreadsheet"
  task data: :environment do
    puts 'Importing Shops'
    data = Roo::Spreadsheet.open('db/seed/coopmartDN.xlsx').sheet('floor_1')
    headers = data.row(1)
    data.each_with_index do |row, idx|
      next if idx == 0
      shop_data = Hash[[headers, row].transpose]
      if Shop.exists?(id: shop_data['id'])
        puts "Shop with id '#{shop_data['id']}' already exists"
        next
      end
      
      shop = Shop.new(shop_data)
      puts "Saving Shop with name #{shop.name}"
      shop.save!
    end
  end
end
