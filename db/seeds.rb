require 'database_cleaner'

puts "Clean database"
DatabaseCleaner.clean_with(:truncation)

puts "Create places & floors & shops & coordinates"
places = JSON.parse(File.read(Rails.root.join('db/seed/place.json')))

places.each do |p|
  place = Place.new name: p['name'], address: p['address'], tel: p['tel'], 
  url: p['url'], floor: p['floor'], description: p['description'],
  url_thumbnail: p['url_thumbnail'], url_images: p['url_images'],
  url_floors: p['url_floors']

  place.save!
    (1..place.floor).each do |i|
      floor = place.floors.new name: "#{i}"
      floor.save!
      shop = place.shops.new name: "shop_#{i}", place_id: place.id, url: 'www.example.com', 
        description: Faker::Lorem.paragraph, floor_id: Random.new.rand(0..place.floor),
        category_id: "#{i}", url_logo: "/logo/#{i}"
      floor.statistics.create! nodes: ["a1", "a2", "a3", "a4"], graph: [["a1", "a2", 5], ["a1", "a4", 1]]
    end
end

puts "Create users"
User.create! first_name: "first", last_name: "last", email: "admin@example.com",
  role: :admin, password: "abcd1234"
(1..10).each do |i|
  User.create! first_name: "client_#{i}", last_name: "last_#{i}", email: "client_#{i}@example.com",
    role: :client, password: "abcd1234"
end

puts "Create directions & markers"
(1..10).each do |i|
  marker = Marker.create! pair_name: "a#{rand(1..10)},a#{rand(1..10)}"
  marker.create_direction direct: "100 200"
end

puts "Create categories"
(1..10).each do
  Category.create! name: Faker::Restaurant.type
end

puts "Done! Please login with [ #{User.first.email} | abcd1234 ]."
