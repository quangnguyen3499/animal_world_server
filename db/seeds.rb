require 'database_cleaner'

puts "Clean database"
DatabaseCleaner.clean_with(:truncation)

puts "Create company"
Company.create!(name: 'company', url: 'www.example.com', ranking: 'A', description: 'some descriptions')

puts "Create company_admins"
(1..10).each do |i|
  CompanyAdmin.create! first_name: "first_#{i}", last_name: "last_#{i}", email: company.daihyo_email,
    role: :admin, password: "abcd1234"
  CompanyAdmin.create! first_name: "worker_#{i}", last_name: "company_#{i}", email: "worker_#{i}@example.com",
    role: :worker, password: "abcd1234"
end

# puts "Create billings"
# Company.all.each do |company|
#   (1..10).each do |i|
#     Billing.create! date: "2021/#{i.to_s.rjust(2, '0')}", employee_count: 1, senkou_count: 1, company_id: company.id,
#       fee: 1000, employee_amount: 10000, senkou_amount: 5000, billing_flag: 1
#   end
# end

# puts "Create employees"
# Company.all.each do |company|
#   (1..10).each do |i|
#     Employee.create! first_name: "employee_#{i}", last_name: "company_#{company.id}", sex: "male", company_id: company.id,
#       kubun: "full_time", shindan_flag: 0
#   end
#   (11..20).each do |i|
#     Employee.create! first_name: "employee_#{i}", last_name: "company_#{company.id}", sex: "female", company_id: company.id,
#       kubun: "senkou", shindan_flag: 0
#   end
# end

# puts "Create energizers"
# current_year = Time.current.year
# years = [current_year, current_year - 1, current_year - 2]
# Employee.all.each do |employee|
#   years.each do |year|
#     Energizer.create! employee_id: employee.id, year: year, simple_react_answer: 1, simple_react_miss: 1,
#       simple_react_fluc: 1, hukugo1_answer: 1, hukugo1_miss: 1, hukugo1_fluc: 1, hukugo2_answer: 1, hukugo2_miss: 1,
#       hukugo2_fluc: 1, hukugo3_answer: 1, hukugo3_miss: 1, hukugo3_fluc: 1, hukugo_ave_answer: 1,
#       hukugo_ave_miss: 1, hukugo_ave_fluc: 1, yashin: 1, otonashi: 1, majime: 1, gaikou: 1, sewasuki: 1, 
#       kisaku: 1, inside_ave: 1, brand_work: 1, brand_office: 1, brand_company: 1, amuse_work: 1, amuse_office: 1,
#       amuse_company: 1, jituri_work: 1, jituri_office: 1, jituri_company: 1, mind_work: 1, mind_office: 1,
#       mind_company: 1, body_kodo_work: 1, body_kodo_office: 1, body_kodo_company: 1, jitugen_work: 1,
#       jitugen_office: 1, jitugen_company: 1, yasuragi_work: 1, yasuragi_office: 1, yasuragi_company: 1,
#       target_value_ave_work: 1, target_value_ave_office: 1, target_value_ave_company: 1
#   end
# end

puts "Done! Please login with [ #{CompanyAdmin.first.email} | abcd1234 ]."
