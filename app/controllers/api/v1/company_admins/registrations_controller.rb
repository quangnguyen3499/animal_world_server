class Api::V1::CompanyAdmins::RegistrationsController < DeviseTokenAuth::RegistrationsController
  skip_after_action :update_auth_header
  skip_before_action :validate_sign_up_params
  before_action :configure_sign_up_params, only: [:create]

  def create
    @resource = CompanyAdmin.find_or_initialize_by email: sign_up_params[:email]
    @resource.assign_attributes(
      first_name: sign_up_params[:first_name],
      last_name: sign_up_params[:last_name],
      role: :admin,
      password: sign_up_params[:password]
    )
    @resource.save!
    json_response :ok, serialize_data(CompanyAdminSerializer, @resource), I18n.t("action.success")
  end

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit :sign_up, keys: CompanyAdmin::CREATE_PARAMS
  end
end
