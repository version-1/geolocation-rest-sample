class Geolocation < ApplicationRecord
  PROVIDERS = %i[ipstack].freeze
  DEFAULT_PROVIDER = :ipstack

  validates :provider_code, presence: true, inclusion: { in: PROVIDERS.map(&:to_s) }
  validates :ip_or_hostname, presence: true

  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :continent_code, presence: true
  validates :continent_name, presence: true
  validates :country_code, presence: true
  validates :country_name, presence: true
  validates :region_code, presence: true
  validates :region_name, presence: true
  validates :city, presence: true
  validates :zip, presence: true

  validates :raw_data, presence: true

  def provider
    @provider ||= self.class.provider_class(provider_code).new(raw_data)
  end

  def location
    provider.location if provider.respond_to?(:location)
  end

  def currency
    provider.currency if provider.respond_to?(:currency)
  end

  def timezone
    provider.timezone if provider.respond_to?(:timezone)
  end

  def connection
    provider.connection if provider.respond_to?(:connection)
  end

  class << self
    def provider_class(provider_code)
      "GeolocationProviders::#{provider_code.to_s.camelize}".constantize
    end

    def from(provider_code, json = {})
      klass = provider_class(provider_code)
      return unless klass.respond_to?(:from)

      # INFO: delegate parse json data to sub classes for providers
      new(klass.from(json.with_indifferent_access))
    end

    def add!(ip_or_hostname)
      klass = provider_class(DEFAULT_PROVIDER)
      return unless klass.respond_to?(:client)

      json = klass.client.search(ip_or_hostname)
      record = from(DEFAULT_PROVIDER, json)
      record.ip_or_hostname = ip_or_hostname

      return if exists?(ip_or_hostname: record.ip_or_hostname, ip_address: record.ip_address)

      record.save!
    end
  end
end
