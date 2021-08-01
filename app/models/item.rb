# == Schema Information
#
# Table name: items
#
#  id           :bigint           not null, primary key
#  discarded_at :datetime
#  discount     :float(24)
#  name         :string(191)
#  price        :bigint
#  status       :integer
#  typical      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_items_on_discarded_at  (discarded_at)
#
class Item < ApplicationRecord
  ATTR = [:name, :typical, :price, :discount, :status, :image]

  has_many_attached :images

  enum typical: {clothes: 0, shoes: 1, appliances: 2, food: 3}
  enum status: {available: 0, outofstock: 1}

  validates :name, uniqueness: true
  validates :typical, :price, :discount, :status, presence: true
end
