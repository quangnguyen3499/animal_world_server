namespace :sample do
  desc 'サンプルデータを登録する'
  task db: :environment do
    20.times do |n|
      Company.create(name: Faker::JapaneseMedia::OnePiece.character,
                     address: Faker::Address.state,
                     postcode: Faker::Number.leading_zero_number(digits: 7),
                     tel: '080-9999-0000',
                     url: Faker::Internet.url,
                     status: 2,
                     detail: Faker::Lorem.sentence,
                     daihyo_last_name: Faker::JapaneseMedia::OnePiece.character,
                     daihyo_first_name: Faker::JapaneseMedia::OnePiece.character,
                     daihyo_email: 'test.user@mail.com')
    end

    20.times do |n|
      Billing.create(company_id: n + 1,
                     employee_count: n + 1,
                     senkou_count: n + 1,
                     fee: n * 20000)
    end
  end
end