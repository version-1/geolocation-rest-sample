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
      CLIENT = GeolocationClients::Ipstack.new(ENV['IPSTACK_API_KEY'])

      def from(json = {})
        json.slice(
          :latitude,
          :longitude,
          :country_code,
          :country_name,
          :continent_code,
          :continent_name,
          :region_code,
          :region_name,
          :city,
          :zip,
          :msa,
          :dma,
          :radius,
        ).merge(
          provider_code: 'ipstack',
          ip_address: json[:ip],
          ip_type: json[:type],
          msa: json.dig(:location, :metro_code),
          dma: json.dig(:location, :area_code),
          radius: json.dig(:location, :radius),
          timezone_code: json.dig(:time_zone, :id),
          currency_code: json.dig(:currency, :code),
          raw_data: json
        )
      end

      def client
        CLIENT
      end
    end
  end
end
