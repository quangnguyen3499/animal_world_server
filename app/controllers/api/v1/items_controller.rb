class Api::V1::ItemsController < Api::V1::BaseController
  before_action :load_item, only: [:edit, :update, :destroy]

  def index
    full_items = Item.latest
    items = if filtering_params.present?
                  @full_items&.filter_by(filtering_params)
                else
                  @full_items
                end
    metadata, paginated_items = pagy(items, page: params[:page], items: params[:itemsPerPage])
    json_response :ok, paginate_data(ItemSerializer, paginated_items, metadata),
                  I18n.t("actions.success")
  end

  def create
    @item = Item.new item_params
    @item.save!
    json_response(:created, serialize_data(ItemSerializer, @item), I18n.t("actions.success"))
  end

  # def import
  #   import_service = Csv::ImportService.new(csv_params)
  #   result = import_service.perform!
  #   errors = result[:errors]
  #   errors.delete_if{|_k, v| v.blank?}
  #   raise if errors[:rollback].present? || !result[:saved]

  #   json_response :ok, {detail: errors[:detail]}, I18n.t("actions.success")
  #   logger.info "----------------------------CSV読み込み成功------------------------------------"
  # rescue StandardError => _e
  #   # uncomment when debugging
  #   # errors ||= e.message
  #   json_response :bad_request, errors, I18n.t("actions.failed")
  # end

  def edit
    json_response :ok, serialize_data(ItemSerializer, @item),
                  I18n.t("actions.success")
  end

  def update
    @item.update! item_params
    json_response(:ok, serialize_data(ItemSerializer, @item), I18n.t("actions.success"))
  end

  def destroy
    @item.discard!
    json_response :ok, "", I18n.t("actions.success")
  end

  private

  def load_item
    @item = Item.find_by(params[:id])
  end
  
  def filtering_params
    params.permit(Item::FILTERING_PARAM)
  end

  def item_params
    params.permit(Item::CREATE_PARAMS)
  end
end
