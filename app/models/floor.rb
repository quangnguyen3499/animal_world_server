# == Schema Information
#
# Table name: floors
#
#  id   :bigint           not null, primary key
#  name :string(191)
#
class Floor < ApplicationRecord
  has_many :statistics
  has_many :shops
end
