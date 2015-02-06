require "uri"
require "active_support/core_ext/object/to_query"

module Lol
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
      File.join "https://#{region}.api.pvp.net/api/lol/#{region}/#{self.class.api_version}/", "#{path}?#{query_string}"
    end

    # Returns just a path from a full api url
    # @return [String]
    def clean_url(url)
      uri = URI.parse(url)
      uri.query = CGI.parse(uri.query).reject { |k| k == 'api_key' }.to_query
      uri.to_s
    end

    # Calls the API via HTTParty and handles errors
    # @param url [String] the url to call
    # @return [String] raw response of the call
    def perform_request url
      if cached? && result = store.get(clean_url(url))
        return JSON.parse(result)
      end

      response = self.class.get(url)
      if response.respond_to?(:code) && !(200...300).include?(response.code)
        raise NotFound.new("404 Not Found") if response.not_found?
        raise InvalidAPIResponse.new(url, response)
      end

      store.setex clean_url(url), ttl, response.to_json if cached?

      response
    end

    # @return [Redis] returns the cache store
    def store
      cache_store[:redis]
    end

    # @return [Boolean] true if the request should be cached
    def cached?
      cache_store[:cached]
    end

    # @return [Fixnum] the ttl to apply to cached keys
    def ttl
      cache_store[:ttl]
    end

    # Initializes a new Request
    # @param api_key [String] the Riot Games API key
    # @param region [String] the region you want to use in API calls
    # @param cache_store [Hash]
    # @option cache_store [Redis] :redis Redis instance to use
    # @option cache_store [Boolean] :cached should the request be cached
    # @option cacche_store [Fixnum] :ttl ttl for cache keys
    # @return [Request]
    def initialize api_key, region, cache_store = {}
      @cache_store = cache_store
      raise InvalidCacheStore if cached? && !store.is_a?(Redis)
      @api_key = api_key
      @region = region
    end
  end
end
