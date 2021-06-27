class Api::V1::Admin::CompanyAdminsController < Api::V1::Admin::BaseController
  before_action :load_company_admin, only: [:show, :destroy, :update]

  def create
    company = Company.find(params[:company_id])
    company_admin = company.company_admins.with_discarded.find_or_initialize_by(email: company_admin_params[:email])
    raise ApiError::RecordNotUnique unless company_admin.new_record? || company_admin.discarded?

    company_admin.assign_attributes(company_admin_params)
    company_admin.password = Faker::Base.regexify(Settings.regx.password_rules.complexity)
    company_admin.save!
    company_admin.undiscard
    company_admin.send_reset_password_instructions(
      email: company_admin.email,
      provider: "email",
      redirect_url: "#{ENV['WEB_URL']}/password/new",
      init: true,
      subject: I18n.t("model.company_admin.password.new_password_instructions")
    )
    json_response :ok, serialize_data(CompanyAdminIndexSerializer, company_admin),
                  I18n.t("model.company_admin.sign_up.waiting_confirm")
  end

  def index
    company_admin_data = CompanyAdmin.by_company_id(params[:company_id]).latest
    metadata, company_admins = pagy(company_admin_data, page: params[:page], items: params[:itemsPerPage])
    json_response :ok, paginate_data(CompanyAdminIndexSerializer, company_admins, metadata, {}),
                  I18n.t("actions.success")
  end

  def show
    json_response(:ok, serialize_data(CompanyAdminIndexSerializer, @company_admin))
  end

  def destroy
    @company_admin.discard!
    json_response(:no_content)
  end

  def update
    if @company_admin.is_daihyo?
      ActiveRecord::Base.transaction do
        @company_admin.company.update!(
          daihyo_first_name: company_admin_params[:first_name],
          daihyo_last_name: company_admin_params[:last_name],
          daihyo_email: company_admin_params[:email]
        )
        @company_admin.update! company_admin_params
      end
    else
      @company_admin.update! company_admin_params
    end
    json_response(:no_content)
  end

  def approve_company
    company_admin = CompanyAdmin.find params[:company_admin_id]
    company = company_admin.company
    company.update(
      status: :approved,
      email_token: "confirmed_#{company.email_token}"
    )
    company_admin.confirm
    CompanyMailer.send_complete_registration(company_admin.company).deliver!
    json_response(:ok, serialize_data(CompanyIndexSerializer, company_admin.company))
  end

  private
  def company_admin_params
    params.permit(CompanyAdmin::COMPANY_ADMIN_PARAMS)
  end

  def load_company_admin
    @company_admin = CompanyAdmin.find params[:id]
  end
end
