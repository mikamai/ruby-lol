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
    # @param [Integer] summoner_id Summoner ID associated with the player
    # @return [Integer] Player's total champion master score
    def total_score summoner_id:
      perform_request api_url "scores/by-summoner/#{summoner_id}"
    end

    # Get all champion mastery entries sorted by number of champion points descending
    #
    # See: https://developer.riotgames.com/api-methods/#champion-mastery-v3/GET_getAllChampionMasteries
    # @param [Integer] summoner_id Summoner ID associated with the player
    # @return [Array<Lol::ChampionMastery>] Champion Masteries
    def all summoner_id:
      result = perform_request api_url "champion-masteries/by-summoner/#{summoner_id}"
      result.map { |c| ChampionMastery.new c }
    end

    # Get a champion mastery by player ID and champion ID
    #
    # See: https://developer.riotgames.com/api-methods/#champion-mastery-v3/GET_getChampionMastery
    # @param [Integer] summoner_id Summoner ID associated with the player
    # @return [Lol::ChampionMastery] Champion Mastery
    def find champion_id, summoner_id:
      result = perform_request api_url "champion-masteries/by-summoner/#{summoner_id}/by-champion/#{champion_id}"
      ChampionMastery.new result
    end
  end
end
