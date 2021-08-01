class Api::V1::ItemsController < ApplicationController
  before_action :load_item, only: [:show, :update, :destroy]

  def index
    full_items = Item.latest
    items = if filtering_params.present?
              full_items&.filter_by(filtering_params)
            else
              full_items
            end
    metadata, paginated_items = pagy(items, page: params[:page], items: params[:itemsPerPage])
    json_response :ok, paginate_data(ItemSerializer, paginated_items, metadata),
                  I18n.t("actions.success")
  end

  def show
    json_response :ok, serialize_data(ItemSerializer, @item), I18n.t("action.success")
  end

  def create
    item = Item.find_or_initialize_by name: item_params[:name]
    raise ApiError::RecordNotUnique unless item.new_record?

    item.save!
    json_response :ok, serialize_data(ItemSerializer, item), I18n.t("action.success")
  end

  def update
    @item.update!(item_params)
    json_response :ok, serialize_data(ItemSerializer, @item), I18n.t("action.success")
  end

  def destroy
    @item.destroy
    json_response(:no_content)
  end

  private
  def item_params
    params.permit(Item::ATTR)
  end

  def load_item
    @item = Item.find(params[:id])
  end

  def filtering_params
    params.permit(Item::FILTERING_PARAM)
  end
end
