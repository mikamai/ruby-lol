module Lol
  # Bindings for the Spectator API.
  #
  # See: https://developer.riotgames.com/api-methods/#spectator-v4
  class SpectatorRequest < Request
    # @!visibility private
    def api_base_path
      "/lol/spectator/#{self.class.api_version}"
    end

    # Get current game information for the given encrypted summoner ID.
    # @param [Integer] summoner_id Encrypted Summoner ID
    # @return [DynamicModel] Current game representation
    def current_game encrypted_summoner_id:
      DynamicModel.new perform_request api_url "active-games/by-summoner/#{encrypted_summoner_id}"
    end

    # Get list of featured games.
    # @return [FeaturedGameList] list of featured games
    def featured_games
      FeaturedGameList.new perform_request api_url "featured-games"
    end
  end
end
