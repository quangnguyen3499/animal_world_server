class Api::V1::Clients::PasswordsController < DeviseTokenAuth::PasswordsController
  skip_before_action :validate_redirect_url_param, only: [:create, :edit]

  def create
    raise ErrorValidate unless resource_params[:email].present?

    @email = get_case_insensitive_field_from_resource_params(:email)
    @resource = find_resource(:uid, @email)
    raise ApiError::RecordNotFound if @resource.nil? || @resource.errors.present?

    @resource.send_reset_password_instructions(
      email: @email,
      provider: "email",
      redirect_url: "#{ENV['WEB_URL']}/password/new"
    )
    json_response(:created)
  end
  
  def edit
    @resource = resource_class.with_reset_password_token(resource_params[:reset_password_token])
    raise ApiError::ErrorVerifyAccount unless @resource && @resource&.reset_password_period_valid?

    handle_redirect_new_password
  end

  def update
    if require_client_password_reset_token? && resource_params[:reset_password_token]
      @resource = resource_class.with_reset_password_token(resource_params[:reset_password_token])
      raise ApiError::Authenticate unless @resource

      @token = @resource.create_token
    else
      @resource = set_user_by_token
    end
    handle_new_password

    json_response(:no_content)
  end

  private
  def resource_params
    params.permit(:email, :redirect_url, :reset_password_token, :password, :password_confirmation)
  end

  def handle_redirect_new_password
    token = @resource.create_token unless require_client_password_reset_token?
    @resource.allow_password_change = true if recoverable_enabled?
    @resource.save!
    yield @resource if block_given?
    if require_client_password_reset_token?
      redirect_to DeviseTokenAuth::Url.generate(resource_params[:redirect_url],
                                                reset_password_token: resource_params[:reset_password_token])
    else
      redirect_header_options = {reset_password: true, init: params[:init] || false}
      redirect_headers = build_redirect_headers(token.token,
                                                token.client,
                                                redirect_header_options)
      redirect_to(@resource.build_auth_url(resource_params[:redirect_url],
                                           redirect_headers))
    end
  end

  def handle_new_password
    raise ApiError::Authenticate unless @resource && @resource.provider == "email"

    raise ApiError::ErrorNewPassword unless @resource.send(resource_update_method, password_resource_params)

    @resource.allow_password_change = false if recoverable_enabled?
    @resource.save!
    yield @resource if block_given?
  end
end
