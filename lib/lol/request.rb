module Lol
  class InvalidAPIResponse < StandardError; end
  class NotFound < StandardError; end

  # Encapsulates common methods for all requests
  # Request classes inherit from this
  class Request
    include HTTParty

    # @!attribute [r] api_key
    #   @return [String] api_key
    attr_reader :api_key


    # @!attribute [rw] region
    #   @return [String] region
    attr_accessor :region

    # Returns a full url for an API call
    # @param version [String] API version to call
    # @param path [String] API path to call
    # @return [String] full fledged url
    def api_url version, path, params = {}
      lol = version == "v2.1" ? "" : "lol"
      query_string = URI.encode_www_form params.merge api_key: api_key
      File.join "http://prod.api.pvp.net/api/", lol, "/#{region}/#{version}/", "#{path}?#{query_string}"
    end

    # Calls the API via HTTParty and handles errors
    # @param url [String] the url to call
    # @return [String] raw response of the call
    def perform_request url
      response = self.class.get(url)
      raise NotFound.new("404 Not Found") if response.respond_to?(:code) && response.not_found?
      raise InvalidAPIResponse.new(response["status"]["message"]) if response.is_a?(Hash) && response["status"]

      response
    end

    def initialize api_key, region
      @api_key = api_key
      @region = region
    end

  end
end
