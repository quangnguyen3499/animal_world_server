# == Schema Information
#
# Table name: statistics
#
#  id       :bigint           not null, primary key
#  graph    :text(65535)
#  floor_id :integer
#  place_id :integer
#
# Indexes
#
#  index_statistics_on_floor_id  (floor_id)
#  index_statistics_on_place_id  (place_id)
#
class Statistic < ApplicationRecord
  serialize :graph, Array
  belongs_to :floor

  def count_shop
    Shop.where(floor_id: self.floor_id, place_id: self.place_id).count
  end

  def nodes
    data = []
    (1..count_shop).each do |i|
      data << "a#{i}"
    end
    data
  end
end
