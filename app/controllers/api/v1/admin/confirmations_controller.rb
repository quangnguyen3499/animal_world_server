class Api::V1::Admin::ConfirmationsController < DeviseTokenAuth::ConfirmationsController
  def show
    front = ENV["WEB_URL"]
    confirmation_token = params[:confirmation_token]
    params[:redirect_url] = "#{front}/admin/password/new?confirmation_token=#{confirmation_token}"
    super
  end

  def confirm
    confirmation_token = params[:confirmation_token]
    sys_admin = SystemAdmin.find_by!(confirmation_token: confirmation_token)
    if sys_admin.update(confirmation_params)
      head :ok
      redirect_to = "http://localhost:8080/admin/signin"
    end
  end
  private
  def confirmation_params
    params.permit(:password)
  end
end
