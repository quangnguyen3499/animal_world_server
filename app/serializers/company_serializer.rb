class CompanySerializer < ApplicationSerializer
  attributes :id, :name, :address, :postcode, :tel, :url
             :ranking, :description, :created_at, :updated_at
end
