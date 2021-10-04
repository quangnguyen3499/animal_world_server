module Api::V1
  class BaseController < ApiController
    before_action :authenticate_api_v1_user!
  end
end
