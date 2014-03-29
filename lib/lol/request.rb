module Lol
  class InvalidAPIResponse < StandardError; end
  class NotFound < StandardError; end
  class InvalidCacheStore < StandardError; end

  # Encapsulates common methods for all requests
  # Request classes inherit from this
  class Request
    include HTTParty

    # @!attribute [r] api_key
    # @return [String] api_key
    attr_reader :api_key


    # @!attribute [rw] region
    # @return [String] region
    attr_accessor :region

    # @!attribute[r] cache_store
    # @return [Object] the cache_store
    attr_reader :cache_store

    # Stub method. Each subclass should have its own api version
    # @return [String] api version
    def self.api_version
      "v1.1"
    end

    # Returns a full url for an API call
    # @param path [String] API path to call
    # @return [String] full fledged url
    def api_url path, params = {}
      query_string = URI.encode_www_form params.merge api_key: api_key
      File.join "http://prod.api.pvp.net/api/lol/#{region}/#{self.class.api_version}/", "#{path}?#{query_string}"
    end

    # Calls the API via HTTParty and handles errors
    # @param url [String] the url to call
    # @return [String] raw response of the call
    def perform_request url
      return result if cached? && result = store.get(url)

      response = self.class.get(url)
      raise NotFound.new("404 Not Found") if response.respond_to?(:code) && response.not_found?
      raise InvalidAPIResponse.new(response["status"]["message"]) if response.is_a?(Hash) && response["status"]

      if cached?
        store.set url, response
        store.expire url, ttl
      end

      response
    end

    def store
      cache_store[:redis]
    end

    def cached?
      cache_store[:cached]
    end

    def ttl
      cache_store[:ttl]
    end

    # Initializes a new Request
    # @param api_key [String] the Riot Games API key
    # @param region [String] the region you want to use in API calls
    # @param cache_store [Redis] the Redis store we want to use
    # @return [Request]
    def initialize api_key, region, cache_store = {}
      @cache_store = cache_store
      raise InvalidCacheStore if cached? && !store.is_a?(Redis)
      @api_key = api_key
      @region = region
    end
  end
end
