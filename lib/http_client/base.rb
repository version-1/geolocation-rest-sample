require 'net/http'

module HttpClient
  class Base
    attr_reader :logger, :base_url, :default_params

    def initialize(logger: Rails.logger, base_url: nil, default_params: {})
      @logger = logger
      @base_url = base_url
      @default_params = default_params
    end

    def get(path, params = {})
      p = default_params.merge(params)
      uri = URI("#{base_url}/#{path}?#{URI.encode_www_form(p)}")

      Net::HTTP.get_response(uri) do |res|
        yield(HttpClient::Response.new(res)) if block_given?
      end

      true
    end
  end
end
