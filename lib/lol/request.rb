require "uri"
require "active_support/core_ext/object/to_query"

module Lol
  class NotFound < StandardError; end
  class TooManyRequests < StandardError; end
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
      url = "#{api_base_url}/api/lol/#{region}/#{self.class.api_version}/#{path}"
      "#{url}?#{api_query_string params}"
    end

    def api_base_url
      "https://#{region}.api.pvp.net"
    end

    def api_query_string params = {}
      URI.encode_www_form params.merge api_key: api_key
    end

    # Returns just a path from a full api url
    # @return [String]
    def clean_url(url)
      uri = URI.parse(url)
      uri.query = CGI.parse(uri.query || '').reject { |k| k == 'api_key' }.to_query
      uri.to_s
    end

    # Calls the API via HTTParty and handles errors
    # @param url [String] the url to call
    # @param verb [Symbol] HTTP verb to use. Defaults to :get
    # @param body [Hash] Body for POST request
    # @param options [Hash] Options passed to HTTParty
    # @return [String] raw response of the call
    def perform_request url, verb = :get, body = nil, options = {}
      options_id = options.inspect
      can_cache = [:post, :put].include?(verb) ? false : cached?
      if can_cache && result = store.get("#{clean_url(url)}#{options_id}")
        return JSON.parse(result)
      end
      response = perform_uncached_request url, verb, body, options
      store.setex "#{clean_url(url)}#{options_id}", ttl, response.to_json if can_cache
      response
    end

    def perform_uncached_request url, verb = :get, body = nil, options = {}
      options[:headers] ||= {}
      options[:headers].merge!({
        "Content-Type" => "application/json",
        "Accept"       => "application/json"
      })
      if [:post, :put].include?(verb)
        options[:body] = body.to_json if body
        options[:headers]['X-Riot-Token'] = api_key
      end
      response = self.class.send(verb, url, options)
      if response.respond_to?(:code) && !(200...300).include?(response.code)
        raise NotFound.new("404 Not Found") if response.not_found?
        raise TooManyRequests.new('429 Rate limit exceeded') if response.code == 429
        raise InvalidAPIResponse.new(url, response)
      end

      if response.respond_to?(:parsed_response)
        response.parsed_response
      else
        response
      end
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
