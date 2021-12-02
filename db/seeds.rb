require 'database_cleaner'

puts "Clean database"
DatabaseCleaner.clean_with(:truncation)

puts "Create floors"
(1..10).each do |f|
  Floor.create! name: "#{f}"
end

puts "Create markers"
(1..38).each do |i|
  (i+1..39).each do |j|
    Marker.create! pair_name: "a#{i}a#{j}"
  end
end

puts "Create cities"
City.create! [{name: "Da Nang"}, {name: "Ho Chi Minh"}, {name: "Ha Noi"}]

puts "Create places & coordinates"
places = JSON.parse(File.read(Rails.root.join('db/seed/place.json')))

places.each do |p|
  Place.create! name: p['name'], address: p['address'], tel: p['tel'], 
    url: p['url'], floor: p['floor'], description: p['description'],
    url_thumbnail: p['url_thumbnail'], url_images: p['url_images'],
    url_floors: p['url_floors'], city_id: p['city_id']
end

puts "Create categories"
Category.create! [{name: "Mua sắm"}, {name: "Ăn uống"}, {name: "Giải trí"}, {name: "Khác"}]

puts "Create users"
User.create! username: "admin", email: "admin@example.com", role: :admin, password: "abcd1234"
(1..10).each do |i|
  User.create! username: "client_#{i}", email: "client_#{i}@example.com",
    role: :client, password: "abcd1234"
end

puts "Create shops, coordinates, markers & directions"
# Rake::Task['import:data'].invoke

puts "Done! Please login with [ #{User.first.email} | abcd1234 ]."
