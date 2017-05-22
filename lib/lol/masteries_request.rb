module Lol
  # Bindings for the Masteries API.
  #
  # See: https://developer.riotgames.com/api-methods/#masteries-v3
  class MasteriesRequest < Request
    # Get mastery pages for a given summoner ID
    # @param [Integer] summoner_id Summoner ID
    # @return [Array<DynamicModel>] Mastery pages
    def by_summoner_id summoner_id
      result = perform_request api_url "masteries/by-summoner/#{summoner_id}"
      result["pages"].map { |p| DynamicModel.new p }
    end
  end
end
