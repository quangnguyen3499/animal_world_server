class ApplicationSerializer
  include JSONAPI::Serializer
  require "date"

  def to_h
    data = serializable_hash[:data]
    if data.is_a? Hash
      data[:attributes]
    elsif data.is_a? Array
      data.pluck(:attributes)
    else
      data
    end
  end

  def self.format_date date
    date&.strftime(Settings.format.date)
  end

  def self.format_money number
    ActiveSupport::NumberHelper.number_to_currency(number, unit: "¥", delimiter: ",", precision: 0, format: "%u%n")
  end
end
