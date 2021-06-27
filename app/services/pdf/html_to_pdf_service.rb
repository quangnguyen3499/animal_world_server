class Pdf::HtmlToPdfService
  attr_reader :template, :data

  def initialize template, billing, remark
    @template = template
    company = billing.company
    @data = {
      billing_date: billing.billing_date,
      payment_date: billing.payment_date,
      total_amount: format_money(billing.total_amount),
      senkou_count: billing.senkou_count,
      senkou_amount: format_money(billing.senkou_amount),
      employee_count: billing.employee_count,
      employee_amount: format_money(billing.employee_amount),
      billing_flag: billing.billing_flag,
      init_cost: format_money(billing.init_cost),
      fee: format_money(billing.fee),
      tax: format_money(billing.tax(billing.total_amount)),
      company_name: company.name,
      postcode: company.postcode,
      address: company.address,
      tel: company.tel,
      remark: remark,
      senkou_unit_price: format_money(Settings.billing.unit_price.senkou),
      employee_unit_price: format_money(Settings.billing.unit_price.employee)
    }
  end

  def perform!
    html = ActionController::Base.render template: template, assigns: data
    WickedPdf.new.pdf_from_string html
  rescue StandardError => e
    Rails.logger.error e.message
    false
  end

  private
  def format_money number
    ActiveSupport::NumberHelper.number_to_currency(number, unit: "¥", delimiter: ",", precision: 0, format: "%u%n")
  end
end
