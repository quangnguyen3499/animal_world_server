class ApiController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include BaseApi
  include Response
  protect_from_forgery unless: -> { request.format.json? }

  rescue_from CanCan::AccessDenied do |exception|
    json_response :forbidden, {}, exception
  end

  def render_authenticate_error
    raise ApiError::Authenticate
  end

  private

  def current_ability
    @current_ability ||= Ability.new(current_auth_resource, params)
  end

  def current_auth_resource
    current_api_v1_user if current_api_v1_user_signed_in?
  end
end