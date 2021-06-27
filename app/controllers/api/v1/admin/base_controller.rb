module Api::V1::Admin
  class BaseController < ApplicationController
    before_action :authenticate_api_v1_system_admin!
  end
end
