# == Schema Information
#
# Table name: directions
#
#  id        :bigint           not null, primary key
#  direct    :text(65535)
#  marker_id :integer
#
# Indexes
#
#  index_directions_on_marker_id  (marker_id)
#
class DirectionSerializer < ApplicationSerializer
  attributes :id, :marker_id
end
