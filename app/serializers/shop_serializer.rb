# == Schema Information
#
# Table name: shops
#
#  id          :bigint           not null, primary key
#  name        :string(191)
#  category_id :integer
#  floor_id    :integer
#  place_id    :integer
#
# Indexes
#
#  index_shops_on_category_id  (category_id)
#  index_shops_on_floor_id     (floor_id)
#  index_shops_on_place_id     (place_id)
#
class ShopSerializer < ApplicationSerializer
  attributes :id, :name
  attribute :coordinate do |object|
    data = object&.coordinate
    {
      longitude: data&.longitude,
      latitude: data&.latitude
    }
  end
end
