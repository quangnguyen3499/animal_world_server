class Api::V1::CompanyAdminsController < Api::V1::BaseController
  before_action :load_company_admin, only: [:update, :show, :destroy]

  def index
    company_admins = CompanyAdmin.latest
    metadata, company_admins = pagy(company_admins, page: params[:page], items: params[:itemsPerPage])
    json_response :ok, paginate_data(CompanyAdminIndexSerializer, company_admins, metadata, {}),
                  I18n.t("actions.success")
  end

  def show
    json_response :ok, serialize_data(CompanyAdminIndexSerializer, @company_admin), I18n.t("actions.success")
  end

  def update
    @company_admin.update!(
      first_name: resource_params[:first_name],
      last_name: resource_params[:last_name],
      email: resource_params[:email]
    )
    json_response :ok, serialize_data(CompanyAdminIndexSerializer, @company_admin), I18n.t("actions.success")
  end

  def destroy
    @company_admin.discard!
    json_response :ok, "", I18n.t("actions.success")
  end

  private

  def resource_params
    params.permit(CompanyAdmin::COMPANY_ADMIN_PARAMS)
  end

  def load_company_admin
    @company_admin = CompanyAdmin.find(params[:id])
  end
end
