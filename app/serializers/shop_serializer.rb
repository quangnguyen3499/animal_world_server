# == Schema Information
#
# Table name: shops
#
#  id          :bigint           not null, primary key
#  description :text(65535)
#  name        :string(191)
#  url         :string(191)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
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
  attributes :id, :name, :url, :description
  attribute :coordinate do |object|
    data = object&.coordinate
    {
      longitude: data&.longitude,
      latitude: data&.latitude
    }
  end
end
