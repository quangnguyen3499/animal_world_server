require "csv"

module ImportSeedData
  extend Rake::DSL
  extend self

  namespace :seed_data do
    desc "Import data for testing"
    task import: :environment do
      [Company, CompanyAdmin].each do |model|
        seed model
      end
    end

    def seed model, parent_folder = "seeds"
      puts "== Load #{model}"
      CSV.foreach(Rails.root.join("db", parent_folder, "#{model.table_name}.csv"), headers: true, encoding: "SJIS") do |row|
        attrs = row.to_h.symbolize_keys
        instance = model.find_by(attrs[:id] ? {id: attrs[:id]} : attrs.except(:password)) || model.new
        instance.assign_attributes attrs
        instance.save validate: false
      end
    end
  end
end
