class Api::V1::Admin::RegistrationsController < DeviseTokenAuth::RegistrationsController
  before_action :authenticate_api_v1_system_admin!
  private
  def sign_up_params
    params.permit(:email, :password, :last_name, :first_name, :role)
  end
end
