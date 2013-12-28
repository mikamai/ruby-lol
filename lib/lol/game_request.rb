module Lol
  class GameRequest < Request
    # Returns the supported API Version
    # @return [String] the supported api version
    def self.api_version
      "v1.2"
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
