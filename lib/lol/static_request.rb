module Lol
  class StaticRequest < Request
    STANDARD_ENDPOINTS = %w(champion item mastery rune summoner_spell)

    def self.api_version
      "v1.2"
    end

    # Returns a full url for an API call
    # Overrides api_url from Request
    # @param path [String] API path to call
    # @return [String] full fledged url
    def api_url path, params = {}
      super(path,params).gsub(/api\/lol/, "api/lol/static-data").gsub(/\/\/#{region}/, "//global")
    end

    STANDARD_ENDPOINTS.each do |endpoint|
      define_method(endpoint) { Proxy.new self, endpoint }
    end

    def map
      Proxy.new self, 'map'
    end

    def realm
      Proxy.new self, 'realm'
    end

    def versions
      Proxy.new self, 'versions'
    end

    def get(endpoint, id=nil, params={})
      return perform_request(api_url("versions")).map {|x| x} if endpoint == "versions"
      id ? find(endpoint, id, params) : all(endpoint, params)
    end

    private

    def find(endpoint, id, params={})
      model_class(endpoint).new \
        perform_request(api_url("#{endpoint.dasherize}/#{id}", params)).to_hash
    end

    def all(endpoint, params={})
      if %w(realm).include? endpoint
        model_class(endpoint).new perform_request(api_url(endpoint.dasherize, params)).to_hash
      else
        perform_request(api_url(endpoint.dasherize, params))["data"].map do |id, values|
          model_class(endpoint).new(values.merge(id: values["id"] || id))
        end
      end
    end

    def model_class(endpoint)
      OpenStruct
    end

    class Proxy
      def initialize(request, endpoint)
        @request = request
        @endpoint = endpoint
      end

      def get(id=nil, params={})
        if id.is_a?(Hash)
          params = id
          id = nil
        end

        @request.get @endpoint, id, params
      end
    end
  end
end
