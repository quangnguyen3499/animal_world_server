module Api::V1
  class BaseController < ApplicationController
    before_action :authenticate_api_v1_company_admin!
    before_action :load_current_company

    def load_current_company
      @company = @current_api_v1_company_admin.company
    end
  end
end
