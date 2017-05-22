module Lol
  # Bindings for the Runes API.
  #
  # See: https://developer.riotgames.com/api-methods/#runes-v3
  class RunesRequest < Request
    # Get rune pages for a given summoner ID
    # @param [Integer] summoner_id Summoner ID
    # @return [Array<DynamicModel>] Rune pages
    def by_summoner_id summoner_id
      result = perform_request api_url "runes/by-summoner/#{summoner_id}"
      result["pages"].map { |p| DynamicModel.new p }
    end
  end
end
