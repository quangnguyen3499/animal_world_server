class Api::V1::StatisticsController < Api::V1::BaseController
  before_action :load_statistic, only: [:update]

  # def create
  #   statistic = @floor.statistics.new(resource_params)
  # end

  def update
    # nodes = [["a", "b", 5], ["a", "n"]]
    nodes = JSON.parse resource_params[:node_params]
    @statistic.update!(nodes: nodes)
    json_response :ok, serialize_data(StatisticSerializer, @statistic), I18n.t("action.success")
  end
  
  def find_shortest_path
    statistic = Statistic.where(
      floor_id: path_params[:floor_id], place_id: path_params[:place_id]
    ).first
    graph = Graph::ShortestPath.new(
      nodes: statistic.nodes,
      graph: statistic.graph,
      source: path_params[:source],
      target: path_params[:target]
    ).perform!
    json_response :ok, graph, I18n.t("action.success")
  end
  
  private
  def resource_params
    params.permit(:id, :node_params)
  end
  
  def path_params
    params.permit(:floor_id, :place_id, :source, :target)
  end
  
  def load_statistic
    @statistic = Statistic.find resource_params[:id]
  end
end