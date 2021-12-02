# == Schema Information
#
# Table name: directions
#
#  id        :bigint           not null, primary key
#  direct    :text(65535)
#  floor_id  :integer
#  marker_id :integer
#  place_id  :integer
#
# Indexes
#
#  index_directions_on_floor_id   (floor_id)
#  index_directions_on_marker_id  (marker_id)
#  index_directions_on_place_id   (place_id)
#
class Direction < ApplicationRecord
  belongs_to :marker, optional: true
end
