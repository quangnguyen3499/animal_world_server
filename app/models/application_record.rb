class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include Discard::Model

  default_scope ->{ kept }
  scope :recover_all, ->(discarded_at){ where(discarded_at: discarded_at).update_all(discarded_at: nil) }
  scope :soft_delete_all, ->{ update_all(discarded_at: Time.current) }
  scope :latest, ->{order(created_at: :desc)}
  scope :latest_by_year, ->(year){where(year: year).order("created_at DESC")}
end
