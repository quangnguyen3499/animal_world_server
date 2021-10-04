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
class Place < ApplicationRecord  
  ATTR = [:name, :address, :tel, :url, :longitude, :latitude, :status, :rating, :description]
  FILTERING_PARAM = [:name, :address, :status, :rating]

  has_many_attached :images
  has_and_belongs_to_many :animals

  enum status: {opening: 0, closed: 1}

  validates :name, uniqueness: true
  validates :status, :address, :tel, :url, :longitude, :latitude, :rating, presence: true
end
