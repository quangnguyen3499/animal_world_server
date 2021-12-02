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
class Place < ApplicationRecord  
  ATTR = [:name, :address, :tel, :url, :description]
  FILTERING_PARAM = [:name, :address]

  belongs_to :city
  has_many :statistics
  has_many :shops
  
  validates :name, uniqueness: true
  validates :address, :tel, :url, presence: true
end
