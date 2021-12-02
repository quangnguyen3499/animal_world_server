# == Schema Information
#
# Table name: places
#
#  id            :bigint           not null, primary key
#  address       :text(65535)
#  description   :text(65535)
#  floor         :integer
#  name          :string(191)
#  tel           :string(191)
#  url           :string(191)
#  url_floors    :string(191)
#  url_images    :string(191)
#  url_thumbnail :string(191)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  city_id       :integer
#
# Indexes
#
#  index_places_on_city_id  (city_id)
#
class PlaceSerializer < ApplicationSerializer
  attributes :id, :name, :address, :floor, :tel, :url, :description, 
             :created_at, :updated_at
  
  attribute :floor_list do |object|
    Floor.first(object.floor).map{ |f|
      {
        floor_id: f.id,
        floor_name: f.name
      }
    }
  end
end
