module Lol
  class ChampionMasteryRequest < V3Request
    # Returns the supported API Version. ChampionMastery end point is not
    # versioned, so just return v1.0 anyway
    # @return [String] v1.0 (ChampionMastery end point is not versioned)
    def self.api_version
      'v1.0'
    end

    # Retrieve champion mastery information for a specific champion
    # @param [FixNum] player_id id of player
    # @param [FixNum] champion_id id of champion
    # @return [ChampionMastery] champion mastery information
    def champion player_id, champion_id
      url = "player/#{player_id}/champion/#{champion_id}"
      result = perform_request(api_url(url))

      ChampionMastery.new(result)
    end

    # Retrieve champion mastery information for all champion
    # @param [FixNum] player_id id of player
    # @return [Array] array of champion mastery information
    def champions player_id
      url = "player/#{player_id}/champions"
      result = perform_request(api_url(url))
      result.map { |c| ChampionMastery.new(c) }
    end

    # Get a player's total champion mastery score, which is sum of individual champion mastery levels
    # @param [FixNum] player_id id of player
    # @return [FixNum] Players mastery score
    def score player_id
      url = "player/#{player_id}/score"
      perform_request(api_url(url)).to_i
    end

    # Get specified number of top champion mastery entries sorted by number of champion points descending
    # @param [FixNum] player_id id of player
    # @option options [Fixnum] :count the number of mastery scores to get. Defaults to 3
    # @return [Array] array of champion mastery information, sorted by number of champion points descending
    def top_champions player_id, options = {}
      if options.keys.select { |k| k.to_sym != :count }.any?
        raise ArgumentError, 'Only :count is allowed as extra parameter'
      end
      url = "player/#{player_id}/topchampions"
      url = api_url(url, options)
      result = perform_request(url)
      result.map { |c| ChampionMastery.new(c) }
    end

    # Returns a full url for an API call
    # @param path [String] API path to call
    # @return [String] full fledged url
    def api_url path, params = {}
      url = "#{api_base_url}/championmastery/location/#{platform}/#{path}"
      "#{url}?#{api_query_string params}"
    end
  end
end
