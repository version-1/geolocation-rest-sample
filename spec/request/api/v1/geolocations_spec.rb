require "rails_helper"

RSpec.describe '/api/v1/geolocations', type: :request do
  before do
    FixtureHelper.setup
  end

  after do
    FixtureHelper.teardown
  end

  let(:email) { user.email }
  let(:user) { User.first }
  let(:token) { Auth::Jwt.encode(email) }
  let(:headers) do
    {
      'Authorization': "Bearer #{token}"
    }
  end

  describe 'GET /api/v1/geolocations' do
    subject { get '/api/v1/geolocations', headers: headers }

    it 'OK 200' do
      subject

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json).to match(
        {
          'data' => [
            {
              'id' => Geolocation.first.uuid,
              'type' => 'geolocations',
              'attributes' => {
                'provider_code' => 'ipstack',
                'ip_or_hostname' => '93.184.215.14',
                'ip_address' => '93.184.215.14',
                'ip_type' => 'ipv4',
                'latitude' => 40.7589111328125,
                'longitude' => -73.97901916503906,
                'continent_code' => 'NA',
                'continent_name' => 'North America',
                'country_code' => 'US',
                'country_name' => 'United States',
                'region_code' => 'NY',
                'region_name' => 'New York',
                'city' => 'Manhattan',
                'zip' => '10020',
                'radius' => nil,
                'msa' => '35620',
                'dma' => '501',
                'timezone_code' => nil,
                'currency_code' => nil,
                'created_at' => be_a(String),
                'updated_at' => be_a(String)
              },
              'relationships' => {
                'user' => {
                  'data' => {
                    'id' => user.uuid,
                    'type' => 'users'
                  }
                },
                'provider' => {
                  'data' => {
                    'id' => Geolocation.first.uuid,
                    'type' => 'geolocation_providers_ipstacks'
                  }
                }
              }
            },
            {
              'id' => Geolocation.second.uuid,
              'type' => 'geolocations',
              'attributes' => {
                'provider_code' => 'ipstack',
                'ip_or_hostname' => '172.67.195.98',
                'ip_address' => '172.67.195.98',
                'ip_type' => 'ipv4',
                'latitude' => 37.76784896850586,
                'longitude' => -122.39286041259766,
                'continent_code' => 'NA',
                'continent_name' => 'North America',
                'country_code' => 'US',
                'country_name' => 'United States',
                'region_code' => 'CA',
                'region_name' => 'California',
                'city' => 'San Francisco',
                'zip' => '94107',
                'radius' => nil,
                'msa' => '41860',
                'dma' => '807',
                'timezone_code' => 'America/Los_Angeles',
                'currency_code' => 'USD',
                'created_at' => be_a(String),
                'updated_at' => be_a(String),
              },
              'relationships' => {
                'user' => {
                  'data' => {
                    'id' => user.uuid,
                    'type' => 'users'
                  }
                },
                'provider' => {
                  'data' => {
                    'id' => Geolocation.second.uuid,
                    'type' => 'geolocation_providers_ipstacks'
                  }
                }
              }
            },
            {
              'id' => Geolocation.third.uuid,
              'type' => 'geolocations',
              'attributes' => {
                'provider_code' => 'ipstack',
                'ip_or_hostname' => '23.220.129.193',
                'ip_address' => '23.220.129.193',
                'ip_type' => 'ipv4',
                'latitude' => 39.043701171875,
                'longitude' => -77.47419738769531,
                'continent_code' => 'NA',
                'continent_name' => 'North America',
                'country_code' => 'US',
                'country_name' => 'United States',
                'region_code' => 'VA',
                'region_name' => 'Virginia',
                'city' => 'Ashburn',
                'zip' => '20147',
                'radius' => nil,
                'msa' => '47900',
                'dma' => '511',
                'timezone_code' => 'America/New_York',
                'currency_code' => 'USD',
                'created_at' => be_a(String),
                'updated_at' => be_a(String)
              },
              'relationships' => {
                'user' => {
                  'data' => {
                    'id' => user.uuid,
                    'type' => 'users'
                  }
                },
                'provider' => {
                  'data' => {
                    'id' => Geolocation.third.uuid,
                    'type' => 'geolocation_providers_ipstacks'
                  }
                }
              }
            }
          ],
          'included' => [
            {
              'id' => user.uuid,
              'type' => 'users',
              'attributes' => {
                'email' => 'jack@example.com',
                'username' => 'jack',
                'created_at' => be_a(String),
                'updated_at' => be_a(String)
              },
              'relationships' => {
                'geolocations' => {
                  'data' => [
                    {
                      'id' => Geolocation.first.uuid,
                      'type' => 'geolocations'
                    },
                    {
                      'id' => Geolocation.second.uuid,
                      'type' => 'geolocations'
                    },
                    {
                      'id' => Geolocation.third.uuid,
                      'type' => 'geolocations'
                    }
                  ]
                }
              }
            },
            {
              'id' => Geolocation.first.uuid,
              'type' => 'geolocation_providers_ipstacks',
              'attributes' => be_a(Hash)
            },
            {
              'id' => Geolocation.second.uuid,
              'type' => 'geolocation_providers_ipstacks',
              'attributes' => be_a(Hash)
            },
            {
              'id' => Geolocation.third.uuid,
              'type' => 'geolocation_providers_ipstacks',
              'attributes' => be_a(Hash)
            }
          ]
        }
      )
    end

    context 'Not authenticated' do
      let(:headers) { {} }
      it 'Unauthorized 401' do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'Unexpected error occured' do
      before do
        allow_any_instance_of(User).to receive(:geolocations).and_raise(StandardError)
      end

      it 'Internal Server Error 500' do
        subject
        expect(response).to have_http_status(:internal_server_error)
      end
    end
  end

  describe 'POST /api/v1/geolocations' do
    let(:api_response) do
      double('api response', body: File.read(Rails.root.join('spec', 'fixtures', 'ipstack_response.json')), code: '200')
    end
    let(:ip_or_hostname) { '162.158.146.57' }

    before do
      allow(Net::HTTP).to receive(:get_response).and_yield(api_response)
    end

    subject do
      post '/api/v1/geolocations', params: { 'geolocation' => { 'ip_or_hostname' => ip_or_hostname } }, headers: headers
    end

    it 'Created 201' do
      subject
      expect(response).to have_http_status(:created)
      expect(response.body).to eq('{"data":null}')
    end

    context 'ip or hostname is already exists' do
      let(:ip_or_hostname) { '93.184.215.14' }

      it 'Bad Request Alreaady Exists 400' do
        subject
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'Not authenticated' do
      let(:headers) { {} }
      it 'Unauthorized 401' do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'Unexpected error occured' do
      before do
        allow(Geolocation).to receive(:add!).and_raise(StandardError)
      end

      it 'Internal Server Error 500' do
        subject
        expect(response).to have_http_status(:internal_server_error)
      end
    end
  end

  describe 'GET /api/v1/geolocations/:uuid' do
    let(:uuid) { Geolocation.first.uuid }
    subject { get "/api/v1/geolocations/#{uuid}", headers: headers }

    it 'OK 200' do
      subject
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to match(
        {
          'data' => {
            'id' => uuid,
            'type' => 'geolocations',
            'attributes' => {
              'provider_code' => 'ipstack',
              'ip_or_hostname' => '93.184.215.14',
              'ip_address' => '93.184.215.14',
              'ip_type' => 'ipv4',
              'latitude' => 40.7589111328125,
              'longitude' => -73.97901916503906,
              'continent_code' => 'NA',
              'continent_name' => 'North America',
              'country_code' => 'US',
              'country_name' => 'United States',
              'region_code' => 'NY',
              'region_name' => 'New York',
              'city' => 'Manhattan',
              'zip' => '10020',
              'radius' => nil,
              'msa' => '35620',
              'dma' => '501',
              'timezone_code' => nil,
              'currency_code' => nil,
              'created_at' => be_a(String),
              'updated_at' => be_a(String)
            },
            'relationships' => {
              'user' => {
                'data' => {
                  'id' => user.uuid,
                  'type' => 'users'
                }
              },
              'provider' => {
                'data' => {
                  'id' => uuid,
                  'type' => 'geolocation_providers_ipstacks'
                }
              }
            }
          },
          'included' => [
            {
              'id' => user.uuid,
              'type' => 'users',
              'attributes' => {
                'email' => 'jack@example.com',
                'username' => 'jack',
                'created_at' => be_a(String),
                'updated_at' => be_a(String)
              },
              'relationships' => {
                'geolocations' => {
                  'data' => [
                    {
                      'id' => Geolocation.first.uuid,
                      'type' => 'geolocations'
                    },
                    {
                      'id' => Geolocation.second.uuid,
                      'type' => 'geolocations'
                    },
                    {
                      'id' => Geolocation.third.uuid,
                      'type' => 'geolocations'
                    }
                  ]
                }
              }
            },
            {
              'id' => uuid,
              'type' => 'geolocation_providers_ipstacks',
              'attributes' => be_a(Hash)
            }
          ]
        }
      )
    end

    context 'Not found resource' do
      let(:uuid) { '00000000-0000-0000-0000-000000000000' }
      it 'Not Found 404' do
        subject
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'Not authenticated' do
      let(:headers) { {} }
      it 'Unauthorized 401' do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'Unexpected error occured' do
      before do
        allow_any_instance_of(User).to receive(:geolocations).and_raise(StandardError)
      end

      it 'Internal Server Error 500' do
        subject
        expect(response).to have_http_status(:internal_server_error)
      end
    end
  end

  describe 'DELETE /api/v1/geolocations/:uuid' do
    let(:uuid) { Geolocation.third.uuid }

    subject { delete "/api/v1/geolocations/#{uuid}", headers: headers }

    it 'OK 200' do
      subject
      expect(JSON.parse(response.body)).to match(
        {
          'data' => {
            'id' => uuid,
            'type' => 'geolocations',
            'attributes' => {
              'provider_code' => 'ipstack',
              'ip_or_hostname' => '23.220.129.193',
              'ip_address' => '23.220.129.193',
              'ip_type' => 'ipv4',
              'latitude' => 39.043701171875,
              'longitude' => -77.47419738769531,
              'continent_code' => 'NA',
              'continent_name' => 'North America',
              'country_code' => 'US',
              'country_name' => 'United States',
              'region_code' => 'VA',
              'region_name' => 'Virginia',
              'city' => 'Ashburn',
              'zip' => '20147',
              'radius' => nil,
              'msa' => '47900',
              'dma' => '511',
              'timezone_code' => 'America/New_York',
              'currency_code' => 'USD',
              'created_at' => be_a(String),
              'updated_at' => be_a(String)
            },
            'relationships' => {
              'user' => {
                'data' => {
                  'id' => user.uuid,
                  'type' => 'users'
                }
              },
              'provider' => {
                'data' => {
                  'id' => uuid,
                  'type' => 'geolocation_providers_ipstacks'
                }
              }
            }
          },
          'included' => [
            {
              'id' => user.uuid,
              'type' => 'users',
              'attributes' => {
                'email' => 'jack@example.com',
                'username' => 'jack',
                'created_at' => be_a(String),
                'updated_at' => be_a(String)
              },
              'relationships' => {
                'geolocations' => {
                  'data' => [
                    {
                      'id' => Geolocation.first.uuid,
                      'type' => 'geolocations'
                    },
                    {
                      'id' => Geolocation.second.uuid,
                      'type' => 'geolocations'
                    }
                  ]
                }
              }
            },
            {
              'id' => uuid,
              'type' => 'geolocation_providers_ipstacks',
              'attributes' => be_a(Hash)
            }
          ]
        }
      )
    end

    context 'Not found resource' do
      let(:uuid) { '00000000-0000-0000-0000-000000000000' }

      subject { delete "/api/v1/geolocations/#{uuid}", headers: headers }

      it 'Not Found 404' do
        subject
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'Not authenticated' do
      let(:headers) { {} }
      it 'Unauthorized 401' do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'Unexpected error occured' do
      before do
        allow_any_instance_of(User).to receive(:geolocations).and_raise(StandardError)
      end

      it 'Internal Server Error 500' do
        subject
        expect(response).to have_http_status(:internal_server_error)
      end
    end
  end
end
