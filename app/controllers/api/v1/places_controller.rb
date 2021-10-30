class Api::V1::PlacesController < Api::V1::BaseController
  before_action :load_place, except: :index
  
  def index
    places = Place.latest.includes(:floors)
    json_response :ok, serialize_data(PlaceSerializer, places), I18n.t("actions.success")
  end

  def create
    place = Place.find_or_initialize_by name: item_params[:name]
    raise ApiError::RecordNotUnique unless place.new_record?

    place.save!
    json_response :ok, serialize_data(PlaceSerializer, place), I18n.t("action.success")
  end
  
  def show
    json_response :ok, serialize_data(PlaceSerializer, @place), I18n.t("action.success")
  end

  def update
    data = @place.update! update_params
    json_response :ok, serialize_data(PlaceSerializer, data), I18n.t("action.success")
  end
  
  def destroy
    @place.destroy
    json_response(:no_content)
  end

  private
  def update_params
    params.permit(Place::ATTR)
  end

  def load_place
    @place = Place.find(params[:id])
  end

  def filtering_params
    params.permit(Place::FILTERING_PARAM)
  end
end