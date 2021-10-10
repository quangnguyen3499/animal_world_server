# == Schema Information
#
# Table name: statistics
#
#  id       :bigint           not null, primary key
#  graph    :string(191)
#  nodes    :string(191)
#  floor_id :integer
#  place_id :integer
#
# Indexes
#
#  index_statistics_on_floor_id  (floor_id)
#  index_statistics_on_place_id  (place_id)
#
class Statistic < ApplicationRecord
  serialize :nodes, Array
  serialize :graph, Array
  belongs_to :floor
end
