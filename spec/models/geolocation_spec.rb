require 'rails_helper'

describe Geolocation do
  before do
    FixtureHelper.setup
  end

  after do
    FixtureHelper.teardown
  end

  module GeolocationProviders
    class TestProvider
      def initialize(raw_data)
        @raw_data = raw_data
      end

      def location
        {
          code: 'US'
        }
      end

      def currency
        {
          code: 'USD'
        }
      end

      def timezone
        {
          code: 'UTC'
        }
      end

      def connection
        {
          code: 'DSL'
        }
      end
    end

    # class without any additional data such as location, currency, timezone, connection
    class TestProviderWithoutAnyAdditionalData
      def initialize(raw_data)
        @raw_data = raw_data
      end
    end
  end

  let(:provider_code) { 'test_provider' }
  subject { Geolocation.new(provider_code: provider_code, raw_data: {}) }

  describe '#provider' do
    it 'returns TestProvider instance' do
      expect(subject.provider).to be_a GeolocationProviders::TestProvider
    end

    context 'when provider is ipstack' do
      let(:provider_code) { 'ipstack' }

      it 'returns Ipstack instance' do
        expect(subject.provider).to be_a GeolocationProviders::Ipstack
      end
    end
  end

  describe '.provider_class' do
    it 'returns TestProvider class' do
      expect(Geolocation.provider_class('test_provider')).to eq(GeolocationProviders::TestProvider)
    end

    it 'returns TestProviderWithoutAnyAdditionalData class' do
      expect(
        Geolocation.provider_class(
          'test_provider_without_any_additional_data'
        )
      ).to eq(GeolocationProviders::TestProviderWithoutAnyAdditionalData)
    end

    it 'returns Ipstack class' do
      expect(Geolocation.provider_class('ipstack')).to eq(GeolocationProviders::Ipstack)
    end

    it 'raises NameError when provider class is not found' do
      expect { Geolocation.provider_class('not_found') }.to raise_error(NameError)
    end
  end

  describe '.from' do
    let(:provider_code) { 'test_provider' }
    let(:json) { JSON.parse(File.read('spec/fixtures/ipstack_response.json')) }
    subject { described_class.from(provider_code, json) }

    it 'returns nil' do
      expect(subject).to eq(nil)
    end

    context 'when provider is ipstack' do
      let(:provider_code) { 'ipstack' }

      it 'returns Geolocation instance' do
        expect(subject.attributes).to match(
          Geolocation.new(
            provider_code: 'ipstack',
            raw_data: json,
            latitude: 49.2752799987793,
            longitude: -123.13249969482422,
            ip_address: '162.158.146.57',
            ip_type: 'ipv4',
            continent_code: 'NA',
            continent_name: 'North America',
            country_code: 'CA',
            country_name: 'Canada',
            region_code: 'BC',
            region_name: 'British Columbia',
            city: 'West End',
            zip: 'V5K 1A1',
            msa: nil,
            dma: nil,
            radius: nil,
            timezone_code: 'America/Vancouver',
            currency_code: 'CAD'
          ).attributes
        )
      end
    end
  end

  describe '.add!' do
    let(:json) { JSON.parse(File.read('spec/fixtures/ipstack_response.json')) }
    let(:user) { User.first }
    let(:ip_or_hostname) { '162.158.146.57' }
    before do
      allow(GeolocationProviders::Ipstack.client).to receive(:search).and_return(json)
    end

    subject { described_class.add!(user, ip_or_hostname) }

    it 'record added' do
      expect { subject }.to change { Geolocation.count }.by(1)
    end

    context 'when record already exists' do
      before do
        allow(Geolocation).to receive(:exists?).and_return(true)
      end

      it 'raise record invalid error' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
