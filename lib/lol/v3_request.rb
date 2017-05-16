require 'active_support/deprecation'

module Lol
  class V3Request < Request
    # Returns the supported API Version.
    # @return [String] v3
    def self.api_version
      'v3'
    end

    # Returns the supported API Version.
    # @return [String] v3
    def api_version
      self.class.api_version
    end

    # Returns the API base domain
    # @return [String] path domain
    def api_base_url
      "https://#{platform}.api.riotgames.com"
    end

    # Returns the API base path, which is everything between the domain and the request-specific path
    # @return [String] API path
    def api_base_path
      "/lol/platform/#{self.class.api_version}"
    end

    # Returns a full url for an API call
    # @param path [String] API path to call
    # @return [String] full fledged url
    def api_url path, params = {}
      url = File.join File.join(api_base_url, api_base_path), path
      "#{url}?#{api_query_string params}"
    end

    def self.platforms
      {
        :br   => 'br1',
        :eune => 'eun1',
        :euw  => 'euw1',
        :jp   => 'jp1',
        :kr   => 'kr1',
        :lan  => 'la1',
        :las  => 'la2',
        :na   => 'na1',
        :oce  => 'oc1',
        :ru   => 'ru',
        :tr   => 'tr1',
      }
    end

    def platform
      self.class.platforms[region.to_sym]
    end

    protected

    def warn_for_deprecation message
      ActiveSupport::Deprecation.warn message
    end
  end
end
