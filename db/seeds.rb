require 'database_cleaner'

puts "Clean database"
DatabaseCleaner.clean_with(:truncation)

puts "Create places $ floors & shops & coordinates"
(1..10).each do |i|
  place = Place.new name: "place_#{i}", address: Faker::Address.city, tel: "5555555555", 
    url: 'www.example.com', floor: i%4, description: Faker::Lorem.paragraph,
    url_thumbnail: "/thumbnail/#{i}", url_images: "/images/#{i}"

  place.save!
    floor = place.floors.new name: "#{i}"
    floor.save!
    shop = place.shops.new name: "shop_#{i}", place_id: place.id, url: 'www.example.com', 
      description: Faker::Lorem.paragraph, floor_id: Random.new.rand(0..place.floor),
      category_id: "#{i}", url_logo: "/logo/#{i}"
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
  marker = Marker.new pair_name: "a#{rand(1..10)},a#{rand(1..10)}"
  marker.save!
    marker.direction.create! direct: "100 200"
end

puts "Create categories"
(1..10).each do
  Category.create! name: Faker::Restaurant.type
end

puts "Done! Please login with [ #{User.first.email} | abcd1234 ]."
