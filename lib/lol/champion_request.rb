module Lol
  # Bindings for the Champion API.
  #
  # See: https://developer.riotgames.com/api-methods/#champion-v3
  class ChampionRequest < Request
    # Returns the supported API Version.
    # @return [String] v3
    def self.api_version
      'v3'
    end

    # Retrieve free champion rotation
    #
    # See: https://developer.riotgames.com/api-methods/#champion-v3/GET_getChampionInfo
    # @return [DynamicModel] free champion rotation arrays
    def champion_rotations
      DynamicModel.new perform_request api_url('champion-rotations')
    end
  end
end
