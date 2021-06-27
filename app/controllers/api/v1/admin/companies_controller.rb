class Api::V1::Admin::CompaniesController < Api::V1::Admin::BaseController
  before_action :load_company, only: [:show, :destroy, :update]
  # authorize_resource

  def index
    companies = Company.available
    json_response :ok, serialize_data(CompanyIndexSerializer, companies)
  end

  def show
    json_response :ok, serialize_data(CompanySerializer, @company), I18n.t("actions.success")
  end

  def statistics
    monthy_shindans = Company.sum_of_shindan
    active_companies = monthy_shindans.pluck(:company_id).uniq.count
    json_response :ok, {
      num_of_diagnoses: monthy_shindans.count,
      num_of_active_companies: active_companies,
      num_of_new_companies: Company.by_current_month.count
    }, I18n.t("actions.success")
  end

  def update
    @company.update!(detail: params[:detail])
    json_response(:ok, CompanySerializer.new(@company).to_h, I18n.t("actions.success"))
  end

  def destroy
    @company.discard!
    json_response(:no_content)
  end

  def discarded
    companies = Company.with_discarded.discarded
    json_response :ok, serialize_data(CompanyDiscardedSerializer, companies)
  end

  def restore
    companies = Company.with_discarded
    company = companies.find(params[:id])
    company.undiscard
    company.save!
    json_response(:no_content)
  end

  private

  def load_company
    @company = Company.find(params[:id])
  end
end
