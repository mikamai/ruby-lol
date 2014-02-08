module Lol
  class StaticRequest < Request
    ENDPOINTS = %w(champion item mastery rune summoner_spell)

    def self.api_version
      "v1"
    end

    # Returns a full url for an API call
    # Overrides api_url from Request
    # @param path [String] API path to call
    # @return [String] full fledged url
    def api_url path, params = {}
      query_string = URI.encode_www_form params.merge api_key: api_key
      File.join "http://prod.api.pvp.net/api/lol/static-data/#{region}/#{self.class.api_version}/", "#{path}?#{query_string}"
    end

    ENDPOINTS.each do |endpoint|
      define_method(endpoint) { Proxy.new self, endpoint }
    end

    private

    class Proxy
      def initialize(request, endpoint)
        @request = request
        @endpoint = endpoint
      end
    end
  end
end
