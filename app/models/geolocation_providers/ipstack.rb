module GeolocationProviders
  class Ipstack
    include ActiveModel::Model
    include ActiveModel::Serialization

    attr_accessor :id, :data

    def initialize(params)
      @id = params[:id]
      @data = params.except(:id).with_indifferent_access
    end

    def serialize
      GeolocationProviders::IpstackSerializer.new(self)
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

    def security
      data[:security]
    end

    class << self
      CLIENT = GeolocationClients::Ipstack.new(ENV.fetch('IPSTACK_API_KEY'))

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
          :radius
        ).merge(
          provider_code: 'ipstack',
          ip_address: json[:ip],
          ip_type: json[:type],
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
