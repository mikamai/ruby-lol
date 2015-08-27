module Lol
  class TournamentProviderRequest < Request
    # Returns the supported API Version
    # @return [String] the supported api version
    def self.api_version
      "v1"
    end

    def api_base_url
      "https://global.api.pvp.net"
    end

    # Returns a full url for an API call
    # @param path [String] API path to call
    # @return [String] full fledged url
    def api_url path, params = {}
      url = "#{api_base_url}/tournament/public/#{self.class.api_version}/#{path}"
    end

    def code
    end

    def provider region, url
      body = {
        region: region,
        url: url
      }
      pau = post_api_url("provider")
      perform_request(pau[:url], :post, body, pau[:options]).body
    end

    def tournament
    end

    # Returns a list of the recent games played by a summoner
    # @param summoner_id [Fixnum] Summoner id
    # @return [Array] an array of games
    def recent summoner_id
      summoner_api_path = "game/by-summoner/#{summoner_id}/recent"
      perform_request(api_url(summoner_api_path))["games"].map do |game_data|
        Game.new game_data
      end
    end
  end
end
