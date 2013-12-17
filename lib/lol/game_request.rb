module Lol
  class GameRequest < Request
    # Returns a list of the recent games played by a summoner
    # @param summoner_id [Fixnum] Summoner id
    # @return [Array] an array of games
    def recent summoner_id
      summoner_api_path = "game/by-summoner/#{summoner_id}/recent"
      perform_request(api_url("v1.1", summoner_api_path))["games"].map do |game_data|
        Game.new game_data
      end
    end
  end
end
