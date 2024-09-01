require "rails_helper"

RSpec.describe '/api/v1', type: :request do
  describe 'GET /api/v1' do
    it 'OK 200' do
      get '/api/v1'
      expect(response.body).to eq('{"message":"ok"}')
    end
  end
end
