# == Schema Information
#
# Table name: places
#
#  id           :bigint           not null, primary key
#  address      :text(65535)
#  description  :text(65535)
#  discarded_at :datetime
#  latitude     :float(24)
#  longitude    :float(24)
#  name         :string(191)
#  rating       :float(24)
#  status       :integer
#  tel          :string(191)
#  url          :string(191)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_places_on_discarded_at  (discarded_at)
#
class PlaceSerializer < ApplicationSerializer
  attributes :id, :name, :address, :tel, :url, :status,
             :longitude, :latitude, :rating, :description, 
             :created_at, :updated_at
end
