class Api::V1::Admin::EnergizersController < Api::V1::Admin::BaseController
  before_action :load_employee
  before_action :current_energizer, only: [:show]
  # authorize_resource

  def index
    current_year = Time.current.year
    years = [current_year, current_year - 1, current_year - 2]
    energizers = []
    years.each do |year|
      energizers.push @employee.energizers.latest_by_year(year).first
    end
    json_response :ok, serialize_data(EnergizerSerializer, energizers.compact), I18n.t("actions.success")
  end

  def show
    json_response :ok, serialize_data(EnergizerSerializer, @energizer), I18n.t("actions.success")
  end

  def create
    energizer = @employee.energizers.new(year: params[:year])
    energizer.assign_attributes energizer_params.transform_values{|val| [nil, ""].include?(val) ? 0 : val}
    energizer.save!
    json_response :ok, serialize_data(EnergizerSerializer, energizer), I18n.t("actions.success")
  end

  private

  def load_employee
    @employee = Employee.find(params[:employee_id])
  end

  def energizer_params
    params.permit(Energizer::UPDATE_PARAMS)
  end

  def current_energizer
    @energizer = @employee.energizers.latest_by_year(params[:year]).first
  end
end
