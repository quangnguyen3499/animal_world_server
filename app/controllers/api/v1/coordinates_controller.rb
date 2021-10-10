class Api::V1::CoordinatesController < Api::V1::BaseController
  before_action :load_place
  before_action :load_floor
  before_action :load_shop, except: :index

  def index
    coordinates = Coordinate.where(shop_id: @floor.shops.ids)
    json_response :ok, serialize_data(CoordinateSerializer, coordinates), I18n.t("actions.success")
  end

  def create
    coordinate = @shop.coordinate.find_or_initialize_by name: item_params[:name]
    raise ApiError::RecordNotUnique unless coordinate.new_record?

    coordinate.save!
    json_response :ok, serialize_data(CoordinateSerializer, coordinate), I18n.t("action.success")
  end
  
  def show
    json_response :ok, serialize_data(CoordinateSerializer, @shop.coordinate), I18n.t("action.success")
  end

  def update
    coordinate = @shop.coordinate
    coordinate.update! update_params
    json_response :ok, serialize_data(CoordinateSerializer, coordinate), I18n.t("action.success")
  end
  
  def destroy
    @shop.coordinate.destroy
    json_response(:no_content)
  end

  private
  def update_params
    params.permit(Coordinate::ATTR)
  end

  def filtering_params
    params.permit(Coordinate::FILTERING_PARAM)
  end
  
  def load_shop
    @shop = Shop.find(params[:shop_id])
  end

  def load_place
    @place = Place.find(params[:place_id])
  end

  def load_floor
    @floor = @place.floors.find(params[:floor_id])
  end
end