class Api::V1::Admin::SystemAdminsController < Api::V1::Admin::BaseController
  before_action :load_system_admin, except: :index

  def index
    system_admins = SystemAdmin.all
    json_response :ok, serialize_data(SystemAdminSerializer, system_admins),
                  I18n.t("actions.success")
  end

  def edit
    json_response :ok, serialize_data(SystemAdminSerializer, @system_admin),
                  I18n.t("actions.success")
  end

  def update
    @system_admin.assign_attributes system_admin_params
    @system_admin.save!
    json_response :ok, serialize_data(SystemAdminSerializer, @system_admin),
                  I18n.t("actions.success")
  end

  def destroy
    @system_admin.discard!
    json_response :ok, "", I18n.t("actions.success")
  end

  private

  def load_system_admin
    @system_admin = SystemAdmin.find params[:id]
  end

  def system_admin_params
    params.permit(:first_name, :last_name, :role, :email)
  end
end
