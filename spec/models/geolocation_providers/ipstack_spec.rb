require 'rails_helper'

describe GeolocationProviders::Ipstack do
  let(:params) do
    JSON.parse(File.read('spec/fixtures/ipstack_response.json')).with_indifferent_access
  end

  subject { described_class.new(params) }

  describe '#initialize' do
    it 'should initialize with params' do
      expect(subject.data).to eq(params)
    end
  end

  describe '#serialize' do
    it 'should return IpstackSerializer' do
      expect(subject.serialize).to be_a(GeolocationProviders::IpstackSerializer)
    end

    it 'should return serialized data' do
      json = JSON.parse(subject.serialize.serializable_hash.to_json)
      expect(json).to match(
        {
          'provider_code' => 'ipstack',
          'location' => {
            'geoname_id' => 6_178_582,
            'capital' => 'Ottawa',
            'languages' => [
              {
                'code' => 'en',
                'name' => 'English',
                'native' => 'English'
              },
              {
                'code' => 'fr',
                'name' => 'French',
                'native' => 'Français'
              }
            ],
            'country_flag' => 'https://assets.ipstack.com/flags/ca.svg',
            'country_flag_emoji' => '\ud83c\udde8\ud83c\udde6',
            'country_flag_emoji_unicode' => 'U+1F1E8 U+1F1E6',
            'calling_code' => '1',
            'is_eu' => false
          },
          'connection' => {
            'asn' => 13_335,
            'isp' => 'Cloudflare',
            'sld' => nil,
            'tld' => nil,
            'carrier' => 'cloudflare',
            'home' => false,
            'organization_type' => 'Internet Hosting Services',
            'isic_code' => 'J6311',
            'naics_code' => '518210'
          },
          'timezone' => {
            'id' => 'America/Vancouver',
            'current_time' => '2024-08-31T14:20:40-07:00',
            'gmt_offset' => -25_200,
            'code' => 'PDT',
            'is_daylight_saving' => true
          },
          'currency' => {
            'code' => 'CAD',
            'name' => 'Canadian Dollar',
            'plural' => 'Canadian dollars',
            'symbol' => 'CA$',
            'symbol_native' => '$'
          },
          'security' => {
            'is_proxy' => false,
            'proxy_type' => nil,
            'is_crawler' => false,
            'crawler_name' => nil,
            'crawler_type' => nil,
            'is_tor' => false,
            'threat_level' => 'low',
            'threat_types' => nil,
            'proxy_last_detected' => nil,
            'proxy_level' => nil,
            'vpn_service' => nil,
            'anonymizer_status' => nil,
            'hosting_facility' => false
          }
        }
      )
    end
  end

  describe '.from' do
    let(:json) { JSON.parse(File.read('spec/fixtures/ipstack_response.json')).with_indifferent_access }

    subject { described_class.from(json) }

    it 'should return hash with required keys' do
      expect(subject.except(:raw_data)).to match(
        'provider_code' => 'ipstack',
        'ip_address' => '162.158.146.57',
        'ip_type' => 'ipv4',
        'continent_code' => 'NA',
        'continent_name' => 'North America',
        'country_code' => 'CA',
        'country_name' => 'Canada',
        'region_code' => 'BC',
        'region_name' => 'British Columbia',
        'city' => 'West End',
        'zip' => 'V5K 1A1',
        'latitude' => 49.2752799987793,
        'longitude' => -123.13249969482422,
        'msa' => nil,
        'dma' => nil,
        'radius' => nil,
        'timezone_code' => 'America/Vancouver',
        'currency_code' => 'CAD'
      )

      expect(subject[:raw_data]).to eq(json)
    end
  end
end
