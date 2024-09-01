class GeolocationSerializer < ActiveModelSerializers::Model
  attributes(
    :provider_code,
    :ip_address,
    :ip_type,
    :latitude,
    :longitude,
    :continent_code,
    :continent_name,
    :country_code,
    :country_name,
    :region_code,
    :region_name,
    :city,
    :zip,
    :radius,
    :msa,
    :dma,
    :timezone_code,
    :currency_code,
    :radius,
    :msa,
    :dma
  )

  attribute :id do
    object.uuid
  end

  attribute :location do
    object.location
  end

  attribute :connection do
    object.connection
  end

  attribute :currency do
    object.currency
  end

  attribute :timezone do
    object.timezone
  end

  attribute :connection do
    object.connection
  end
end
