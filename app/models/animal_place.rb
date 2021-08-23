class AnimalPlace < ApplicationRecord
  belongs_to :animal
  belongs_to :place
end
