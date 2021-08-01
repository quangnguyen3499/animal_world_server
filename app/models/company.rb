# == Schema Information
#
# Table name: companies
#
#  id           :bigint           not null, primary key
#  address      :string(191)
#  description  :text(65535)
#  discarded_at :datetime
#  name         :string(191)
#  postcode     :string(191)
#  ranking      :string(191)
#  tel          :string(191)
#  url          :string(191)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_companies_on_discarded_at  (discarded_at)
#
class Company < ApplicationRecord
  ATTR = [:name, :address, :postcode, :tel, :url, :ranking, :description]

  validates :name, :address, :postcode, :tel, :url, :ranking, presence: true
end
