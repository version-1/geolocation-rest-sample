require 'rails_helper'
require 'net/http'

RSpec.describe GeolocationClients::Ipstack do
  let(:api_key) { 'api_key' }
  subject { described_class.new(api_key) }

  describe '#initialize' do
    it 'sets the client' do
      expect(subject.client).to be_a(HttpClient::Base)
    end
  end

  describe '#search' do
    let(:client) { double('ipstack client dummy') }
    let(:raw_response) do
      double('raw response').tap do |d|
        allow(d).to receive(:code).and_return('200')
        allow(d).to receive(:body).and_return(File.read('spec/fixtures/ipstack_response.json'))
      end
    end
    let(:response) { HttpClient::Response.new(raw_response) }

    before do
      allow(client).to receive(:get).and_yield(response)
      allow(subject).to receive(:client).and_return(client)
    end

    it 'returns a response' do
      res = subject.search('ip_or_hostname')
      expect(res.status).to eq(200)
      expect(res.json).to_not eq('')
    end

    context 'when request is not successful' do
      context 'endpoint return with not 2xx' do
        let(:raw_response) do
          double('raw response').tap do |d|
            allow(d).to receive(:code).and_return('403')
            allow(d).to receive(:body).and_return('{"error": "Unauthorized Error"}')
          end
        end

        it 'raise request error' do
          expect do
            subject.search('ip_or_hostname')
          end.to raise_error(GeolocationClients::Error::RequestError)
        end
      end

      context 'endpoint return with error object' do
        let(:raw_response) do
          double('raw response').tap do |d|
            allow(d).to receive(:code).and_return('200')
            allow(d).to receive(:body).and_return(File.read('spec/fixtures/ipstack_error_response.json'))
          end
        end

        it 'raise request error' do
          expect do
            subject.search('ip_or_hostname')
          end.to raise_error(GeolocationClients::Error::RequestError)
        end
      end
    end
  end
end
