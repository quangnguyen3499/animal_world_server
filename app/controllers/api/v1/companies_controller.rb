class Api::V1::CompaniesController < ApplicationController
  def update
    company = Company.first
    company.update! update_params
    json_response :ok, serialize_data(CompanySerializer, company), I18n.t("action.success")
  end

  private
  def update_params
    params.permit(Company::ATTR)
  end
end