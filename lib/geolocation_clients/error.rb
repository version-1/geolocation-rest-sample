module GeolocationClients
  class RequestError < StandardError
    attr_reader :response, :error

    def initialize(response:, error:)
      super
      @response = response
      @error = error
    end

    def message
      return "Request failed with status #{response.status}" if response.present?
      return "Request failed with error #{error}" if error.present?

      nil
    end
  end
end
