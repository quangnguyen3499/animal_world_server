module BaseApi
  extend ActiveSupport::Concern
  include Pagy::Backend

  included do
    include HandleError

    rescue_from StandardError do |e|
      case
      when e.is_a?(ActiveRecord::RecordInvalid)
        handle_error! e, e.record
      else
        handle_error! e
      end
    end
  end
end
