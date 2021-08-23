require 'database_cleaner'

puts "Clean database"
DatabaseCleaner.clean_with(:truncation)

puts "Create places"
(1..10).each do |i|
  Place.create! name: "place_#{i}", address: Faker::Address.city, longitude: Faker::Address.longitude,
    latitude: Faker::Address.latitude, tel: "5555555555", url: 'www.example.com', status: i%2,
    rating: 5, description: Faker::Lorem.paragraph
end

puts "Create users"
User.create! first_name: "first", last_name: "last", email: "admin@example.com",
  role: :admin, password: "abcd1234"
(1..10).each do |i|
  User.create! first_name: "client_#{i}", last_name: "last_#{i}", email: "client_#{i}@example.com",
    role: :client, password: "abcd1234"
end

puts "Create animals"
(1..10).each do |i|
  Animal.create! name: [
    Faker::Creature::Animal.name, Faker::Creature::Bird.common_name, Faker::Creature::Cat.name, 
    Faker::Creature::Dog.name, Faker::Creature::Horse.name
  ].sample, typical: i%5, quantity: i*1000, description: Faker::Lorem.paragraph
end

puts "Done! Please login with [ #{User.first.email} | abcd1234 ]."
