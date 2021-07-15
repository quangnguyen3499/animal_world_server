class Api::V1::ClientsController < Api::V1::BaseController
  before_action :load_client, only: [:update, :show, :destroy]

  def index
    clients = Client.latest
    metadata, clients = pagy(clients, page: params[:page], items: params[:itemsPerPage])
    json_response :ok, paginate_data(ClientIndexSerializer, clients, metadata, {}),
                  I18n.t("actions.success")
  end

  def show
    json_response :ok, serialize_data(ClientIndexSerializer, @client), I18n.t("actions.success")
  end

  def update
    @client.update!(
      first_name: resource_params[:first_name],
      last_name: resource_params[:last_name],
      email: resource_params[:email]
    )
    json_response :ok, serialize_data(ClientIndexSerializer, @client), I18n.t("actions.success")
  end

  def destroy
    @client.discard!
    json_response :ok, "", I18n.t("actions.success")
  end

  private

  def resource_params
    params.permit(Client::CLIENT_PARAMS)
  end

  def load_client
    @client = Client.find(params[:id])
  end
end
