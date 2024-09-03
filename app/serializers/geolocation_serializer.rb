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

  belongs_to :user

  def id
    object.uuid
  end

  # INFO: return provider-specific fields
  has_one :provider do |serializer|
    serializer.object.provider
  end
end
