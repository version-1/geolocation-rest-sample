module GeolocationClients
  class Ipstack
    attr_reader :api_key, :client

    BASE_URL = 'https://api.ipstack.com'.freeze

    def initialize(api_key, base_url: BASE_URL)
      @client = HttpClient::Base.new(
        base_url: base_url,
        default_params: { access_key: api_key }
      )
    end

    def search(ip_or_hostname)
      res = nil
      client.get(ip_or_hostname) do |response|
        if error_response?(response) || !response.success?
          raise GeolocationClients::Error::RequestError.new(response: response, error: nil)
        end

        res = response
      end

      res
    rescue => e
      Rails.logger.error(e)
      raise e if e.is_a?(GeolocationClients::Error::RequestError)

      raise GeolocationClients::Error::RequestError.new(response: nil, error: e)
    end

    # Determine if the response is an format of error object in ipstack side.
    # The endpoint can return error object with 200 status code.
    def error_response?(response)
      json = response.json
      json.key?(:error) && json.key?(:success) && !json[:success]
    end
  end
end
