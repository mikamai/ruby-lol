module Lol
  class InvalidAPIResponse < StandardError
    attr_reader :raw

    def initialize url, response
      @raw = extract_raw_response_info response
      super "#{raw[:status]} calling #{url}"
    end

    private

    def extract_raw_response_info response
      {
        headers: extract_raw_headers(response),
        body:    extract_raw_body(response),
        status:  extract_raw_status(response)
      }
    end

    def extract_raw_headers response
      response.respond_to?(:headers) && response.headers || {}
    end

    def extract_raw_body response
      if response.respond_to?(:parsed_response)
        response.parsed_response
      elsif response.respond_to?(:body)
        response.body
      else
        response
      end
    end

    def extract_raw_status response
      if response.is_a?(Hash) && response['status']
        response['status']['message']
      elsif response.respond_to?(:response)
        "#{response.response.code} #{response.response.message}"
      else
        "Unknown Error"
      end
    end
  end
end
