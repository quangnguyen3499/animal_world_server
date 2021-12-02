# == Schema Information
#
# Table name: cities
#
#  id   :bigint           not null, primary key
#  name :string(191)
#
class CitySerializer < ApplicationSerializer
  attributes :id, :name
end
