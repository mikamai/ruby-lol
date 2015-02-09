module Lol
  class FeaturedGamesRequest < Request
    def self.api_version
      "v1.0"
    end

    def api_url path, params = {}
      "#{api_base_url}/observer-mode/rest/#{path}?#{api_query_string params}"
    end

    def get
      DynamicModel.new perform_request api_url "featured"
    end
  end
end
