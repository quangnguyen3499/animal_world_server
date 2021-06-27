source "https://rubygems.org"
git_source(:github) {|repo| "https://github.com/#{repo}.git"}

ruby "2.6.6"

gem "bootsnap", ">= 1.4.2", require: false
gem "config"
gem "figaro"
gem "jsonapi-serializer"
gem "jbuilder", "~> 2.7"
gem "mysql2", ">= 0.4.4"
gem "puma", "~> 4.1"
gem "rack-attack"
gem "rack-cors"
gem "ransack"
gem "rails", "= 6.0.3.6"
gem "redis", "~> 4.0"
gem "sidekiq"
gem "sidekiq-cron"
gem "sidekiq-status"
gem "devise"
gem "rails-i18n"
gem "pagy"
gem "aws-sdk-s3", require: false
gem "cancancan"
gem "discard"
gem "faker"
gem "money"
gem "wicked_pdf"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "factory_bot_rails"
  gem "pry"
  gem "pry-byebug"
  gem "rubocop-rails", require: false
  gem "rails-erd"
  gem 'wkhtmltopdf-binary'
end

group :development, :staging do
  gem "letter_opener_web", "~> 1.0"
end

group :development do
  gem "listen", "~> 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console"
  gem "annotate"
end

group :test do
  gem "shoulda-matchers"
  gem "rspec-rails"
  gem "database_cleaner"
  gem "timecop"
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "simplecov", require: false
end

group :production do
  gem "wkhtmltopdf-heroku"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
