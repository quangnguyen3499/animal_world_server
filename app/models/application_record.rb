class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :latest, ->{order(created_at: :desc)}
  scope :latest_by_year, ->(year){where(year: year).order("created_at DESC")}
end
