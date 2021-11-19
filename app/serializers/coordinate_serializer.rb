# == Schema Information
#
# Table name: coordinates
#
#  id        :bigint           not null, primary key
#  latitude  :bigint
#  longitude :bigint
#  shop_id   :integer
#
# Indexes
#
#  index_coordinates_on_shop_id  (shop_id)
#
class CoordinateSerializer < ApplicationSerializer
  attributes :shop_id, :longitude, :latitude
end
