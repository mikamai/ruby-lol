module Lol
  class StaticRequest < Request
    # @!visibility private
    def api_base_path
      "/lol/static-data/#{self.class.api_version}"
    end

    {
      "champion"       => "champions",
      "item"           => "items",
      "mastery"        => "masteries",
      "rune"           => "runes",
      "summoner_spell" => "summoner_spells"
    }.each do |old_endpoint, new_endpoint|
      define_method new_endpoint do
        Proxy.new self, new_endpoint
      end
    end

    def language_strings params={}
      perform_request(api_url "language-strings", params).to_hash["data"]
    end

    def languages
      perform_request api_url "languages"
    end

    def maps
      Proxy.new self, "maps"
    end

    def profile_icons params={}
      all "profile_icons", params
    end

    def realms
      Proxy.new self, "realms"
    end

    def versions
      Proxy.new self, "versions"
    end

    def get(endpoint, id=nil, params={})
      return perform_request(api_url("versions")) if endpoint == "versions"
      id ? find(endpoint, id, params) : all(endpoint, params)
    end

    private

    def find(endpoint, id, params={})
      OpenStruct.new \
        perform_request(api_url("#{endpoint.dasherize}/#{id}", params)).to_hash
    end

    def all(endpoint, params={})
      if %w(realms).include? endpoint
        OpenStruct.new perform_request(api_url(endpoint.dasherize, params)).to_hash
      else
        perform_request(api_url(endpoint.dasherize, params))["data"].map do |id, values|
          OpenStruct.new(values.merge(id: values["id"] || id))
        end
      end
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
