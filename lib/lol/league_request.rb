module Lol
  # Bindings for the League API.
  #
  # See: https://developer.riotgames.com/api-methods/#league-v3
  class LeagueRequest < V3Request
    # @!visibility private
    def api_base_path
      "/lol/league/#{api_version}"
    end

    # Get the challenger league for a given queue
    # @param [String] queue Queue identifier. See the list of game constants (developer.riotgames.com/game-constants.html) for the available queue identifiers
    # @return [LeagueList] Challenger league
    def find_challenger queue: 'RANKED_SOLO_5x5'
      LeagueList.new perform_request api_url "challengerleagues/by-queue/#{queue}"
    end

    # Get the master league for a given queue
    # @param [String] queue Queue identifier. See the list of game constants (developer.riotgames.com/game-constants.html) for the available queue identifiers
    # @return [LeagueList] lMaster league
    def find_master queue: 'RANKED_SOLO_5x5'
      LeagueList.new perform_request api_url "masterleagues/by-queue/#{queue}"
    end

    # Get leagues in all queues for a given summoner ID
    # @param [Integer] summoner_id Summoner ID associated with the player
    # @return [Array<LeagueList>] List of leagues summoner is participating in
    def summoner_leagues summoner_id:
      result = perform_request api_url "leagues/by-summoner/#{summoner_id}"
      result.map { |c| LeagueList.new c }
    end

    # Get league positions in all queues for a given summoner ID
    # @param [Integer] summoner_id Summoner ID associated with the player
    # @return [Array<LeaguePosition>] list of league positions
    def summoner_positions summoner_id:
      result = perform_request api_url "positions/by-summoner/#{summoner_id}"
      result.map { |c| LeaguePosition.new c }
    end

    # Retrieves leagues data for summoner, including leagues for all of summoner's teams
    # @deprecated Please use {LeagueRequest#summoner_leagues} instead
    # @param [Array<String>]
    # @return Hash{String => Array<League>}
    def get(*summoner_ids)
      if summoner_ids.size == 1
        warn_for_deprecation "LeagueRequest#get(#{summoner_ids[0]}) has been deprecated. Use LeagueRequest#summoner_leagues(summoner_id: #{summoner_ids[0]}) instead"
      else
        warn_for_deprecation "LeagueRequest#get(#{summoner_ids.inspect}) has been deprecated. Use LeagueRequest#summoner_leagues with each summoner id"
      end
      summoner_ids.inject({}) do |memo, summoner_id|
        memo.update summoner_id.to_s => summoner_leagues(summoner_id: summoner_id)
      end
    end

    # Retrieves leagues entry data for summoner, including league entries for all of summoner's teams
    # @deprecated Please use {LeagueRequest#summoner_leagues} instead
    # @param [Array<String>]
    # @return Hash{String => Array<League>}
    # TODO: Change name to entries?
    def get_entries(*summoner_ids)
      get(*summoner_ids)
    end

    # Retrieves challenger tier leagues
    # @deprecated Please use {LeagueRequest#find_challenger} instead
    # @param [String] game queue type
    # @return [League]
    def challenger(game_queue_type="RANKED_SOLO_5x5")
      warn_for_deprecation "LeagueRequest#challenger(#{game_queue_type}) has been deprecated. Use LeagueRequest#find_challenger(queue: #{game_queue_type}) instead"
      find_challenger queue: game_queue_type
    end

    # Retrieves master tier leagues
    # @deprecated Please use {LeagueRequest#find_master} instead
    # @param [String] game queue type
    # @return [League]
    def master(game_queue_type="RANKED_SOLO_5x5")
      warn_for_deprecation "LeagueRequest#master(#{game_queue_type}) has been deprecated. Use LeagueRequest#find_master(queue: #{game_queue_type}) instead"
      find_master queue: game_queue_type
    end
  end
end
