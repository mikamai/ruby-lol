module Lol
  # Bindings for the Champion Mastery API.
  #
  # See: https://developer.riotgames.com/api-methods/#champion-mastery-v3
  class ChampionMasteryRequest < V3Request
    # @!visibility private
    def api_base_path
      "/lol/champion-mastery/#{api_version}"
    end

    # Get a player's total champion mastery score, which is the sum of individual champion mastery levels
    #
    # See: https://developer.riotgames.com/api-methods/#champion-mastery-v3/GET_getChampionMasteryScore
    # @param [Fixnum] summoner_id Summoner ID associated with the player
    # @return [Fixnum] Player's total champion master score
    def total_score summoner_id:
      perform_request api_url "scores/by-summoner/#{summoner_id}"
    end

    # Get all champion mastery entries sorted by number of champion points descending
    #
    # See: https://developer.riotgames.com/api-methods/#champion-mastery-v3/GET_getAllChampionMasteries
    # @param [Fixnum] summoner_id Summoner ID associated with the player
    # @return [Array<Lol::ChampionMastery>] Champion Masteries
    def all summoner_id:
      result = perform_request api_url "champion-masteries/by-summoner/#{summoner_id}"
      result.map { |c| ChampionMastery.new c }
    end

    # Get a champion mastery by player ID and champion ID
    #
    # See: https://developer.riotgames.com/api-methods/#champion-mastery-v3/GET_getChampionMastery
    # @param [Fixnum] summoner_id Summoner ID associated with the player
    # @return [Lol::ChampionMastery] Champion Mastery
    def find champion_id, summoner_id:
      result = perform_request api_url "champion-masteries/by-summoner/#{summoner_id}/by-champion/#{champion_id}"
      ChampionMastery.new result
    end

    # Retrieve champion mastery information for a specific champion
    # @deprecated Please use {ChampionMasteryRequest#find} instead.
    # @param [Fixnum] player_id id of player
    # @param [Fixnum] champion_id id of champion
    # @return [ChampionMastery] champion mastery information
    def champion player_id, champion_id
      warn_for_deprecation "ChampionMasteryRequest#champion(#{player_id}, #{champion_id}) has been deprecated. Use ChampionMasteryRequest#find(#{champion_id}, summoner_id: #{player_id}) instead"
      find champion_id, summoner_id: player_id
    end

    # Retrieve champion mastery information for all champion
    # @deprecated Please use {ChampionMasteryRequest#all} instead.
    # @param [Fixnum] player_id id of player
    # @return [Array] array of champion mastery information
    def champions player_id
      warn_for_deprecation "ChampionMasteryRequest#champions(#{player_id}) has been deprecated. Use ChampionMasteryRequest#all(summoner_id: #{player_id}) instead"
      all summoner_id: player_id
    end

    # Get a player's total champion mastery score, which is sum of individual champion mastery levels
    # @deprecated Please use {ChampionMasteryRequest#score} instead.
    # @param [FixNum] player_id id of player
    # @return [FixNum] Players mastery score
    def score player_id
      warn_for_deprecation "ChampionMasteryRequest#score(#{player_id}) has been deprecated. Use ChampionMasteryRequest#total_score(summoner_id: #{player_id})"
      total_score summoner_id: player_id
    end

    # Get specified number of top champion mastery entries sorted by number of champion points descending
    # @deprecated Please use {ChampionMasteryRequest#all} instead, manually limiting the amount of results
    # @param [FixNum] player_id id of player
    # @option options [Fixnum] :count the number of mastery scores to get. Defaults to 3
    # @return [Array] array of champion mastery information, sorted by number of champion points descending
    def top_champions player_id, options = {}
      if options.keys.select { |k| k.to_sym != :count }.any?
        raise ArgumentError, 'Only :count is allowed as extra parameter'
      end
      count = options.fetch :count, 3
      warn_for_deprecation "ChampionMasteryRequest#top_champions(#{player_id}, count: #{count}) has been deprecated. Use ChampionMasteryRequest#all(summoner_id: #{player_id})[0, #{count}] instead"
      all(summoner_id: player_id)[0, count]
    end
  end
end
