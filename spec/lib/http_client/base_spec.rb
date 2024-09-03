require 'rails_helper'
require 'net/http'

RSpec.describe HttpClient::Base do
  let(:logger) { double('logger') }
  let(:base_url) { 'http://example.com' }
  let(:default_params) { { key: 'value' } }

  subject { described_class.new(logger: logger, base_url: base_url, default_params: default_params) }

  describe '#initialize' do
    it 'sets the logger' do
      expect(subject.logger).to eq(logger)
    end

    it 'sets the base_url' do
      expect(subject.base_url).to eq(base_url)
    end

    it 'sets the default_params' do
      expect(subject.default_params).to eq(default_params)
    end
  end

  describe '#get' do
    let(:path) { 'path' }
    let(:params) { { key: 'value' } }
    let(:response) do
      double('response').tap do |d|
        allow(d).to receive(:body).and_yield('{ "message": "ok" }')
        allow(d).to receive(:code).and_return('200')
      end
    end

    before do
      allow(Net::HTTP).to receive(:get_response)
        .with(URI("#{base_url}/#{path}?key=value"))
        .and_return(response)
    end

    it 'returns a response' do
      expect(subject.get(path, params)).to be_truthy
    end

    context 'when a block is given' do
      it 'yields the response' do
        subject.get(path, params) do |r|
          expect(r.status).to eq(200)
          expect(r.body).to eq('{ "message": "ok" }')
          expect(r.success?).to eq(true)
        end
      end

      context 'when request is not successful' do
        let(:response) do
          double('response').tap do |d|
            allow(d).to receive(:body).and_yield('{ "error": "error" }')
            allow(d).to receive(:code).and_return('400')
          end
        end

        it 'yields the response' do
          subject.get(path, params) do |r|
            expect(r.status).to eq(400)
            expect(r.body).to eq('{ "error": "error" }')
            expect(r.success?).to eq(false)
          end
        end
      end
    end
  end
end
