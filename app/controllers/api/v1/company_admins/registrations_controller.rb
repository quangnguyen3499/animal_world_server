class Api::V1::CompanyAdmins::RegistrationsController < DeviseTokenAuth::RegistrationsController
  skip_after_action :update_auth_header
  skip_before_action :validate_sign_up_params
  before_action :configure_sign_up_params, only: [:create]

  def create
    success = false
    @company = Company.find_or_initialize_by(name: sign_up_params[:name], daihyo_email: sign_up_params[:daihyo_email])
    @company.assign_attributes(sign_up_params)
    @company.status = :temp_registration
    return render_create_error(I18n.t("model.company.errors.exist")) unless @company.new_record?

    ActiveRecord::Base.transaction do
      @company.save!
      @resource = @company.company_admins.find_or_initialize_by email: sign_up_params[:daihyo_email]
      @resource.assign_attributes(
        first_name: sign_up_params[:daihyo_first_name],
        last_name: sign_up_params[:daihyo_last_name],
        role: :admin,
        password: sign_up_params[:daihyo_password]
      )
      @resource.save!
      CompanyMailer.send_confirmation_instructions(@company).deliver!
      success = true
    end

    render_create_success if success
  end

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit :sign_up, keys: CompanyAdmin::CREATE_PARAMS
  end

  def render_create_success
    json_response :ok, CompanySerializer.new(@company).to_h, I18n.t("model.company_admin.sign_up.waiting_confirm")
  end

  def render_create_error err_message = nil
    handle_error! err_message
  end
end
