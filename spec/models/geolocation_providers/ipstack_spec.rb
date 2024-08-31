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

  describe '#location' do
    it 'should return location data' do
      expect(subject.location).to eq(params[:location])
    end
  end

  describe '#currency' do
    it 'should return currency data' do
      expect(subject.currency).to eq(params[:currency])
    end
  end

  describe '#timezone' do
    it 'should return timezone data' do
      expect(subject.timezone).to eq(params[:time_zone])
    end
  end

  describe '#connection' do
    it 'should return connection data' do
      expect(subject.connection).to eq(params[:connection])
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
