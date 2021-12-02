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
class StatisticSerializer < ApplicationSerializer
  attributes :id, :floor_id, :place_id, :nodes
end
