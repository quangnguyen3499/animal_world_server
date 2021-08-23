module Response
  extend ActiveSupport::Concern

  included do
    def exception_format exception, code
      {
        error_code: code,
        error_message: exception.message.to_s.split("::").last
      }
    end

    def json_response status, object = nil, message = nil, _error = {}
      render json: {
        status: Rack::Utils.status_code(status),
        message: message,
        data: object
      }.to_json, status: status
    end

    def serialize_data model, data, options = {}
      model.new(data, options).to_h
    end

    def paginate_data model, data, meta, options = {}
      {
        items: serialize_data(model, data, options),
        itemsPerPage: meta.items,
        page: meta.page,
        serverItemsLength: meta&.count,
        total_pages: meta.pages
      }
    end
  end
end
