module Lol
  class CurrentGameRequest < Request
    def self.api_version
      'v1.0'
    end

    def api_url path, params = {}
      "#{api_base_url}/observer-mode/rest/consumer/#{path}?#{api_query_string params}"
    end

    def spectator_game_info platform_id, summoner_id
      url = api_url "getSpectatorGameInfo/#{platform_id}/#{summoner_id}"
      DynamicModel.new perform_request(url)
    end
  end
end
