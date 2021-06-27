class Api::V1::Admin::ShindanSenkousController < Api::V1::Admin::BaseController
  before_action :load_data
  # authorize_resource

  def show
    shindan = @energizer.shindan_senkous.latest_by_year(params[:year]).first
    data = if shindan
             serialize_data(ShindanSenkouSerializer, shindan)
           else
             {
               "company_id": @employee.company_id,
               "employee_id": @employee.id,
               "energizer_id": @energizer.id,
               "year": params[:year],
               "is_employee": !@employee.senkou?,
               "shindan_flag": @employee.shindan_flag,
               "allow_shindan": @energizer.allow_shindan,
               "detail": {}
             }
           end
    json_response :ok, data, I18n.t("actions.success")
  end

  private

  def load_data
    @employee = Employee.find(params[:employee_id])
    @energizer = @employee.energizers.latest_by_year(params[:year]).first
    raise ApiError::RecordNotFound unless @energizer
  end
end
