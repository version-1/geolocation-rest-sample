module HttpClient
  class Response
    attr_reader :data, :body

    def initialize(data)
      @data = data
      @body = data.body
    end

    def success?
      status >= 200 && status < 300
    end

    def status
      data.code.to_i
    end

    def json
      JSON.parse(body).with_indifferent_access
    end
  end
end
