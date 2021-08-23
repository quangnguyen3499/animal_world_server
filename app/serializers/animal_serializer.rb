# == Schema Information
#
# Table name: animals
#
#  id           :bigint           not null, primary key
#  description  :text(65535)
#  discarded_at :datetime
#  name         :string(191)
#  quantity     :integer
#  typical      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_animals_on_discarded_at  (discarded_at)
#
class AnimalSerializer < ApplicationSerializer
  attributes :id, :typical, :name, :quantity, 
    :description, :created_at, :updated_at

  # attribute :image do |object|
  #   #  if object.images.attached?
  # end
end
