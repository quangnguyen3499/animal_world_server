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
class Animal < ApplicationRecord
  ATTR = [:name, :typical, :quantity, :image, :description]
  FILTERING_PARAM = [:name, :typical]
  
  has_many_attached :images
  has_many :animal_places
  has_many :places, through: :animal_places

  enum typical: {animal: 0, bird: 1, cat: 2, dog: 3, horse: 4}

  validates :name, uniqueness: true
  validates :typical, :quantity, presence: true
end
