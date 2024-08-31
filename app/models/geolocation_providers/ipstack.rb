module GeolocationProviders
  class Ipstack
    include ActiveModel::Model
    attr_accessor :data

    def initialize(params)
      @data = params
    end

    def location
      data[:location]
    end

    def currency
      data[:currency]
    end

    def timezone
      data[:time_zone]
    end

    def connection
      data[:connection]
    end

    class << self
      def from(json = {})
        {
          provider_code: 'ipstack',
          ip_address: json[:ip],
          ip_type: json[:type],
          latitude: json[:latitude],
          longitude: json[:longitude],
          continent_code: json[:continent_code],
          continent_name: json[:continent_name],
          country_code: json[:country_code],
          country_name: json[:country_name],
          region_code: json[:region_code],
          region_name: json[:region_name],
          city: json[:city],
          zip: json[:zip],
          timezone_code: json[:time_zone][:id],
          currency_code: json[:currency][:code],
          raw_data: json
        }
      end
    end
  end
end
