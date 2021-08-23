class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include BaseApi
  include Response

  rescue_from CanCan::AccessDenied do |exception|
    json_response :forbidden, {}, exception
  end

  def render_authenticate_error
    raise ApiError::Authenticate
  end

  private

  def check_auth_upload
    render_authenticate_error unless current_api_v1_user
  end

  def current_ability
    @current_ability ||= Ability.new(current_auth_resource, params)
  end

  def current_auth_resource
    current_api_v1_user if current_api_v1_user_signed_in?
  end
end
