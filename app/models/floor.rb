# == Schema Information
#
# Table name: floors
#
#  id       :bigint           not null, primary key
#  name     :string(191)
#  place_id :integer
#
# Indexes
#
#  index_floors_on_place_id  (place_id)
#
class Floor < ApplicationRecord
  has_many :statistics
  has_many :shops
  belongs_to :place
end
