# == Schema Information
#
# Table name: items
#
#  id           :bigint           not null, primary key
#  discarded_at :datetime
#  name         :string(191)
#  typical      :integer
#  updated_by   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_items_on_discarded_at  (discarded_at)
#  index_items_on_updated_by    (updated_by)
#
class Item < ApplicationRecord
  # before_discard do
  #   raise ApiError::Undeletable if admin
  # end

  CREATE_PARAMS = [:typical, :name, :updated_by]

  # FILTERING_PARAM

  enum typical: {supply: 0, food: 1}

  validates :typical, :name, :updated_by, presence: true
end
