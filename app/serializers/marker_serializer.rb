# == Schema Information
#
# Table name: markers
#
#  id        :bigint           not null, primary key
#  pair_name :string(191)
#
class MarkerSerializer < ApplicationSerializer
  attributes :id, :pair_name
end
