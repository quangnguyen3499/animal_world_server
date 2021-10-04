class Api::V1::User::SessionsController < DeviseTokenAuth::SessionsController
  before_action :authenticate_api_v1_user!, only: [:destroy]
  wrap_parameters User, include: [:email, :password]

  def create
    raise ApiError::ErrorValidate unless resource_params[:email].present? && resource_params[:password].present?

    @resource = User.find_by email: resource_params[:email]
    return render_email_not_exist unless @resource.present?

    valid_password = @resource.valid_password?(resource_params[:password])
    return render_password_incorrect unless valid_password

    token = @resource.create_token
    @resource.save
    sign_in(:user, @resource, store: false, bypass: false)
    json_response(:ok, SessionSerializer.new(@resource, {params: {token: token}}).to_h)
  end

  def destroy
    client = @token.client
    @token.clear!
    unless current_api_v1_user && client && current_api_v1_user.tokens[client]
      raise ApiError::ErrorSignOut
    end

    current_api_v1_user.tokens.delete(client)
    current_api_v1_user.save!
    json_response(:no_content)
  end

  private
  def resource_params
    params.permit(*params_for_resource(:sign_in), :client_id)
  end

  def render_password_incorrect
    handle_error! I18n.t("model.user.sign_in.password_incorrect")
  end

  def render_account_not_confirm
    handle_error! I18n.t("model.user.sign_in.account_not_confirm")
  end

  def render_place_not_approved
    handle_error! I18n.t("model.place.errors.not_approved")
  end

  def render_email_not_exist
    handle_error! I18n.t("model.user.sign_in.email_not_exist")
  end
end
