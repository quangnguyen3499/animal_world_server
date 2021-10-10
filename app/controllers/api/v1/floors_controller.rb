class Api::V1::FloorsController < Api::V1::BaseController
  before_action :load_place, only: [:show, :update, :destroy]

  def index
    floors = @place.floors
    json_response :ok, serialize_data(FloorSerialzer, floors), I18n.t("actions.success")
  end

  def create
    floor = @place.floors.find_or_initialize_by name: item_params[:name]
    raise ApiError::RecordNotUnique unless floor.new_record?

    floor.save!
    json_response :ok, serialize_data(FloorSerialzer, floor), I18n.t("action.success")
  end
  
  def show
    json_response :ok, serialize_data(FloorSerialzer, @floor), I18n.t("action.success")
  end

  def update
    floor = @floor.update! update_params
    json_response :ok, serialize_data(FloorSerialzer, floor), I18n.t("action.success")
  end
  
  def destroy
    @floor.destroy
    json_response(:no_content)
  end

  private
  def update_params
    params.permit(Floor::ATTR)
  end

  def load_place
    @place = Place.find(params[:place_id])
  end

  def load_floor
    @floor = @place.floors.find(params[:id])
  end
end