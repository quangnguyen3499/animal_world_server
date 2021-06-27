class Api::V1::Companies::ConfirmationsController < ApplicationController
  def show
    @company = Company.find_by(email_token: params[:email_token])
    raise ApiError::RecordNotFound unless @company

    if @company.temp_registration?
      return render_confirm_failed unless @company.persisted? && @company.token_expire_date >= Time.current

      @company.email_authenticated!
      CompanyMailer.send_approve_request(@company).deliver
    end
    @company.update email_token: "confirmed_#{@company.email_token}"
    render_confirm_success
  end

  private

  def render_confirm_failed
    json_response :bad_request, {}, I18n.t("model.company.errors.token_invalid")
  end

  def render_confirm_success
    res = CompanySerializer.new(@company).to_h
    json_response :ok, res, I18n.t("model.company_admin.sign_up.confirmed")
  end
end
