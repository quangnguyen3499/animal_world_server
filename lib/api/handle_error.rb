module HandleError
  include Response

  def handle_error! error, obj = nil
    key = error.is_a?(Symbol) ? error : error.class.name.demodulize.underscore.to_sym
    error_message = key.to_s == "string" ? error : I18n.t("api_error.#{key}")
    err_details = obj.errors.messages if obj
    render json: {
      status: error_code_from(key),
      error_message: error_message.presence,
      details: err_details
    }.to_json, status: error_code_from(key)
  end

  def error_code_from key
    ApiErrorCode::ERROR_CODES[key] || ApiErrorCode::ERROR_CODES[:fallback]
  end
end
