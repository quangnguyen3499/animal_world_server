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
class ItemSerializer < ApplicationSerializer
  attributes :id, :typical, :name, :price, :discount,
             :status, :image, :created_at, :updated_at

  def image
    if object.image.attached?
      {
        url: rails_blob_url(object.image)
      }
    end
  end
end
