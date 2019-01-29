module Lol
  # Bindings for the League API.
  #
  # See: https://developer.riotgames.com/api-methods/#league-v3
  class LeagueRequest < Request
    # @!visibility private
    def api_base_path
      "/lol/league/#{api_version}"
    end

    # Get the challenger league for a given queue
    # @param [String] queue Queue identifier. See the list of game constants (developer.riotgames.com/game-constants.html) for the available queue identifiers
    # @return [DynamicModel] Challenger league
    def find_challenger queue: 'RANKED_SOLO_5x5'
      DynamicModel.new perform_request api_url "challengerleagues/by-queue/#{queue}"
    end

    # Get the master league for a given queue
    # @param [String] queue Queue identifier. See the list of game constants (developer.riotgames.com/game-constants.html) for the available queue identifiers
    # @return [DynamicModel] lMaster league
    def find_master queue: 'RANKED_SOLO_5x5'
      DynamicModel.new perform_request api_url "masterleagues/by-queue/#{queue}"
    end

    # Get leagues in all queues for a given summoner ID
    # @param [Integer] encrypted_summoner_id Encrypted summoner ID associated with the player
    # @return [Array<DynamicModel>] List of leagues summoner is participating in
    def summoner_leagues encrypted_summoner_id:
      result = perform_request api_url "leagues/by-summoner/#{encrypted_summoner_id}"
      result.map { |c| DynamicModel.new c }
    end

    # Get league positions in all queues for a given summoner ID
    # @param [Integer] encrypted_summoner_id Encrypted summoner ID associated with the player
    # @return [Array<DynamicModel>] list of league positions
    def summoner_positions encrypted_summoner_id:
      result = perform_request api_url "positions/by-summoner/#{encrypted_summoner_id}"
      result.map { |c| DynamicModel.new c }
    end
  end
end
