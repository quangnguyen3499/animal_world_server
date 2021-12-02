class Api::V1::CitiesController < Api::V1::BaseController
  def index
    cities = City.all
    json_response :ok, serialize_data(CitySerializer, cities), I18n.t("actions.success")
  end
end