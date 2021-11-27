require 'database_cleaner'

puts "Clean database"
DatabaseCleaner.clean_with(:truncation)

puts "Create floors"
(1..10).each do |f|
  Floor.create! name: "#{f}"
end

puts "Create places & coordinates"
places = JSON.parse(File.read(Rails.root.join('db/seed/place.json')))

places.each do |p|
  place = Place.new name: p['name'], address: p['address'], tel: p['tel'], 
  url: p['url'], floor: p['floor'], description: p['description'],
  url_thumbnail: p['url_thumbnail'], url_images: p['url_images'],
  url_floors: p['url_floors']

  place.save!
    (1..place.floor).each do |i|
      place.statistics.create! floor_id: i, nodes: ["a1", "a2", "a3", "a4"], graph: [["a1", "a2", 5], ["a1", "a4", 1]]
    end
end

puts "Create categories"
Category.create! [{name: "Mua sắm"}, {name: "Ăn uống"}, {name: "Giải trí"}, {name: "Khác"}]

puts "Create users"
User.create! username: "admin", email: "admin@example.com", role: :admin, password: "abcd1234"
(1..10).each do |i|
  User.create! username: "client_#{i}", email: "client_#{i}@example.com",
    role: :client, password: "abcd1234"
end

puts "Create directions & markers"
(1..10).each do |i|
  marker = Marker.create! pair_name: "a#{rand(1..10)},a#{rand(1..10)}"
  marker.create_direction direct: "100 200"
end

puts "Create shops & coordinates"
Rake::Task['import:data'].invoke

puts "Done! Please login with [ #{User.first.email} | abcd1234 ]."
