module ApiErrorCode
  ERROR_CODES = {
    authenticate: 401,
    error_sign_out: 405,
    record_not_found: 404,
    error_verify_account: 407,
    error_new_password: 408,
    error_validate: 422,
    fallback: 400
  }
  RESPONSE_HEADER_CODES = {
    authenticate: 401,
    error_sign_out: 405,
    record_not_found: 404,
    error_verify_account: 407,
    error_new_password: 408,
    error_validate: 422,
    fallback: 400
  }
end
