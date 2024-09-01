class GeolocationSerializer < ActiveModel::Serializer
  attributes(
    :provider_code,
    :ip_or_hostname,
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
    :created_at,
    :updated_at
  )

  def id
    object.uuid
  end

  attribute :location do |serializer|
    serializer.object.location
  end

  attribute :connection do |serializer|
    serializer.object.connection
  end

  attribute :currency do |serializer|
    serializer.object.currency
  end

  attribute :timezone do |serializer|
    serializer.object.timezone
  end
end
