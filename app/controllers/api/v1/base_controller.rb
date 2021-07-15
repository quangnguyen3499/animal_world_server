module Api::V1
  class BaseController < ApplicationController
    before_action :authenticate_api_v1_company_admin!
    authorize_resource
  end
end
