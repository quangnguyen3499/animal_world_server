class Api::V1::UsersController < Api::V1::BaseController
  before_action :load_user, except: :index

  def index
    users = User.all
    json_response :ok, serialize_data(UserSerializer, users),
                  I18n.t("actions.success")
  end

  def edit
    json_response :ok, serialize_data(UserSerializer, @user),
                  I18n.t("actions.success")
  end

  def update
    @user.assign_attributes user_params
    @user.save!
    json_response :ok, serialize_data(UserSerializer, @user),
                  I18n.t("actions.success")
  end

  def destroy
    @user.destroy
    json_response :ok, "", I18n.t("actions.success")
  end

  private

  def load_user
    @user = User.find params[:id]
  end

  def user_params
    params.permit(:username, :role, :email)
  end
end
