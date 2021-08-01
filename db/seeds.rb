require 'database_cleaner'

puts "Clean database"
DatabaseCleaner.clean_with(:truncation)

puts "Create company"
Company.create! name: 'company', address: Faker::Address.city, postcode: "550000", tel: "5555555555", 
  url: 'www.example.com', ranking: 'A', description: Faker::Lorem.paragraph

puts "Create company_admins"
CompanyAdmin.create! first_name: "first", last_name: "last", email: "admin@example.com",
  role: :admin, password: "abcd1234"
(1..10).each do |i|
  CompanyAdmin.create! first_name: "worker_#{i}", last_name: "company_#{i}", email: "worker_#{i}@example.com",
    role: :worker, password: "abcd1234"
end

puts "Create clients"
(1..10).each do |i|
  Client.create! first_name: "first_#{i}", last_name: "last_#{i}", email: "client_#{i}@example.com",
    member_level: i%4, password: "abcd1234"
end

puts "Create items"
(1..10).each do |i|
  Item.create! name: "item_#{i}", typical: i%4, price: 100000, discount: 0.1, status: i%2
end

puts "Done! Please login with [ #{CompanyAdmin.first.email} | abcd1234 ]."
