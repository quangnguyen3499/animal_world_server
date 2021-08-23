class Api::V1::PlacesController < Api::V1::BaseController  
  def index
    full_places = Place.latest
    places = if filtering_params.present?
              full_places&.filter_by(filtering_params)
            else
              full_places
            end
    metadata, paginated_items = pagy(places, page: params[:page], items: params[:itemsPerPage])
    json_response :ok, paginate_data(PlaceSerializer, paginated_items, metadata),
                  I18n.t("actions.success")
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
    place = Place.first
    place.update! update_params
    json_response :ok, serialize_data(PlaceSerializer, place), I18n.t("action.success")
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