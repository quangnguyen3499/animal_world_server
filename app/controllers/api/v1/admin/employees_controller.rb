class Api::V1::Admin::EmployeesController < Api::V1::Admin::BaseController
  before_action :load_company, only: [:index, :create]
  before_action :load_employee, only: [:edit, :update, :destroy]
  before_action :load_employees, only: [:index]

  FILE_VALIDATIONS = {
    ext_name: ".csv",
    max_size: 1e+6
  }

  def index
    employees = if filtering_params.present?
                  @employees&.filter_by(filtering_params)
                else
                  @employees
                end
    metadata, paginated_employees = pagy(employees, page: params[:page], items: params[:itemsPerPage])
    json_response :ok, paginate_data(EmployeeSerializer, paginated_employees, metadata),
                  I18n.t("actions.success")
  end

  def create
    ActiveRecord::Base.transaction do
      @employee = @company.employees.new(employee_params.merge({shindan_flag: :undiagnosed}))
      current_year = Time.current.year
      years = [current_year, current_year - 1, current_year - 2]
      @employee.save! do
        years.each{|year| @employee.energizers.create!(year: year)}
      end
    end
    json_response(:created, serialize_data(EmployeeSerializer, @employee), I18n.t("actions.success"))
  end

  def import
    errors = {}
    if csv_params[:csv_file][:file_size].to_i > FILE_VALIDATIONS[:max_size]
      errors[:rollback] << I18n.t("csv.errors.file_size_over")
    end
    if File.extname(csv_params[:csv_file][:file_name]).downcase != FILE_VALIDATIONS[:ext_name]
      errors[:rollback] << I18n.t("csv.errors.file_type_invalid")
    end
    raise if errors[:rollback].present?

    import_service = Csv::ImportService.new(csv_params)
    result = import_service.perform!
    errors = result[:errors]
    errors.delete_if{|_k, v| v.blank?}
    raise if errors[:rollback].present? || !result[:saved]

    json_response :ok, {detail: errors[:detail]}, I18n.t("actions.success")
    logger.info "----------------------------CSV読み込み成功------------------------------------"
  rescue StandardError => _e
    # errors ||= e.message
    json_response :bad_request, errors, I18n.t("actions.failed")
  end

  def edit
    json_response :ok, serialize_data(EmployeeSerializer, @employee), I18n.t("actions.success")
  end

  def update
    profile_pdf = employee_params[:profile_pdf]
    @employee.update! employee_params.except(:profile_pdf)
    @employee.profile_pdf.attach(profile_pdf) if profile_pdf.present?
    json_response(:ok, serialize_data(EmployeeSerializer, @employee), I18n.t("actions.success"))
  end

  def destroy
    @employee.discard!
    json_response :ok, "", I18n.t("actions.success")
  end

  def remove_pdf
    employee = Employee.find params[:employee_id]
    employee.profile_pdf.purge_later
    json_response :ok, {}, I18n.t("actions.success")
  end

  private

  def employee_params
    params.permit(Employee::CREATE_UPDATE_PARAMS)
  end

  def csv_params
    params.permit(:company_id, csv_file: {})
  end

  def load_company
    @company = Company.find params[:company_id]
  end

  def load_employee
    @employee = Employee.find params[:id]
  end

  def filtering_params
    params.permit(Employee::FILTERING_PARAM)
  end

  def load_employees
    @employees = @company&.employees
  end
end
