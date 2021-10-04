class Api::V1::AnimalsController < Api::V1::BaseController
  before_action :load_animal, only: [:show, :update, :destroy]

  def index
    full_animals = Animal.latest
    animals = if filtering_params.present?
              full_animals&.filter_by(filtering_params)
            else
              full_animals
            end
    metadata, paginated_items = pagy(animals, page: params[:page], items: params[:itemsPerPage])
    json_response :ok, paginate_data(AnimalSerializer, paginated_items, metadata),
                  I18n.t("actions.success")
  end

  def show
    json_response :ok, serialize_data(AnimalSerializer, @item), I18n.t("action.success")
  end

  def create
    animal = Animal.find_or_initialize_by name: item_params[:name]
    raise ApiError::RecordNotUnique unless animal.new_record?

    animal.save!
    json_response :ok, serialize_data(AnimalSerializer, animal), I18n.t("action.success")
  end

  def update
    @animal.update!(animal_params)
    json_response :ok, serialize_data(AnimalSerializer, @animal), I18n.t("action.success")
  end

  def destroy
    @animal.destroy
    json_response(:no_content)
  end

  private
  def animal_params
    params.permit(Animal::ATTR)
  end

  def load_animal
    @animal = Animal.find(params[:id])
  end

  def filtering_params
    params.permit(Animal::FILTERING_PARAM)
  end
end
