# == Schema Information
#
# Table name: coordinates
#
#  id        :bigint           not null, primary key
#  latitude  :bigint
#  longitude :bigint
#  name      :string(191)
#  shop_id   :integer
#
# Indexes
#
#  index_coordinates_on_shop_id  (shop_id)
#
class Coordinate < ApplicationRecord
  belongs_to :shop
end
