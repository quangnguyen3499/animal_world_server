class Api::V1::StatisticsController < Api::V1::BaseController
  before_action :load_statistic, only: [:update]

  def update
    nodes = JSON.parse resource_params[:node_params]
    @statistic.update!(nodes: nodes)
    json_response :ok, serialize_data(StatisticSerializer, @statistic), I18n.t("actions.success")
  end
  
  def find_shortest_path
    statistic = Statistic.where(
      floor_id: path_params[:floor_id], place_id: path_params[:place_id]
    ).first
    graph = Graph::ShortestPath.new(
      nodes: statistic.nodes,
      graph: statistic.graph,
      source: "a" + path_params[:source],
      target: "a" + path_params[:target]
    ).perform!
    #get real path
    path = get_path_reality(graph[:path])
    graph[:distance] = "∞" unless path.present?
    data = OpenStruct.new(id: SecureRandom.hex(2), path: path, distance: graph[:distance])
    json_response :ok, serialize_data(ShortestPathSerializer, data), I18n.t("actions.success")

    # exp: 
    # source: "a1"
    # target: "a2"
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

  def get_path_reality(path)
    format_marker = Array.new
    result = String.new
    #convert ['a1', 'a2', 'a3', 'a4'] => ['a1a2', 'a2a3', 'a3a4']
    graph_data(path).each_cons(2) do |pre, nxt|
      format_marker.push(pre + nxt)
    end
    #create real path
    format_marker.each do |r|
      if r == format_marker.last
        result << find_direction(r)
        next
      end
      result << find_direction(r) << " "
    end
    result
  end

  def graph_data(graph)
    #split to num array
    result = graph.split('a').reject(&:empty?)
    #append 'a' to head
    result.map{|s| s.sub(/\A(?!a)/, "a")}
  end

  def find_direction pair_name
    format_pair_name = pair_name.split('a').reject(&:empty?)
    temp_arr = format_pair_name[0].to_f > format_pair_name[1].to_f ? format_pair_name.reverse : format_pair_name
    data = temp_arr.map{|s| s.sub(/\A(?!a)/, "a")}.join

    marker = Marker.find_by(pair_name: data)
    @direction = Direction.find_by(floor_id: path_params[:floor_id], place_id: path_params[:place_id], 
      marker_id: marker.id).direct
  end
end