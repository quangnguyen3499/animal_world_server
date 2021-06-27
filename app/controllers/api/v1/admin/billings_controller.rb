class Api::V1::Admin::BillingsController < Api::V1::Admin::BaseController
  before_action :load_billing, only: [:show]

  def index
    params[:date] ||= Date.current.strftime(Settings.format.month)
    billings = Billing.filter_by_date(params[:date]).latest
    json_response :ok, serialize_data(BillingSerializer, billings),
                  I18n.t("actions.success")
  end

  def export
    csv = Csv::ExportService.new params[:date]
    send_data csv.perform!
  end

  def show
    json_response :ok, serialize_data(BillingIndexSerializer, @billing), I18n.t("actions.success")
  end

  def send_bill
    billing = Billing.find(params[:billing_id])
    file_path = "billing_mailer/bill_record"
    pdf_raw = Pdf::HtmlToPdfService.new(file_path, billing, billing_params[:remark]).perform!
    return json_response(:bad_request, {}, I18n.t("actions.success")) unless pdf_raw.present?

    BillingMailer.send_billing_monthly(billing, billing_params.merge!(pdf_raw: pdf_raw)).deliver!
    json_response :ok, {}, I18n.t("actions.success")
  end

  private
  def load_billing
    @billing = Billing.find(params[:id])
  end

  def billing_params
    params.permit(:email, :remark, :pdf_raw)
  end
end
