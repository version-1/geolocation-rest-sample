module GeolocationProviders
  class IpstackSerializer < ActiveModel::Serializer
    attributes(
      :location,
      :currency,
      :timezone,
      :connection,
      :security
    )

    def self.type
      'geolocation_provider'
    end

    attribute :provider_code do
      'ipstack'
    end
  end
end
