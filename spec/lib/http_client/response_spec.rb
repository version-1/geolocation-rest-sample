require 'rails_helper'
require 'net/http'

RSpec.describe HttpClient::Response do
  let(:data) { double("response") }
  let(:code) { '200' }

  before do
    allow(data).to receive(:body).and_return('{ "message": "ok" }')
    allow(data).to receive(:code).and_return(code)
  end

  subject { described_class.new(data) }

  describe '#initialize' do
    it 'sets the data' do
      expect(subject.data).to eq(data)
    end
  end

  describe '#body' do
    it 'returns the body' do
      expect(subject.body).to eq('{ "message": "ok" }')
    end
  end

  describe '#success?' do
    it 'returns true when status is 2xx' do
      expect(subject.success?).to eq(true)
    end

    context 'returns false when status is greater equal than 300' do
      let(:code) { '300' }

      it 'returns false' do
        expect(subject.success?).to eq(false)
      end
    end

    context 'when status is less than 200' do
      let(:code) { '199' }

      it 'returns false' do
        expect(subject.success?).to eq(false)
      end
    end
  end

  describe '#status' do
    it 'returns the status' do
      expect(subject.status).to eq(200)
    end
  end

  describe '#json' do
    it 'returns the body parsed as json' do
      expect(subject.json).to eq({ 'message' => 'ok' })
    end
  end
end
