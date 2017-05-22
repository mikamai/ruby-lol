module Lol
  # Bindings for the Champion API.
  #
  # See: https://developer.riotgames.com/api-methods/#champion-v3
  class ChampionRequest < V3Request
    # Retrieve all champions
    #
    # See: https://developer.riotgames.com/api-methods/#champion-v3/GET_getChampions
    # @param free_to_play [Boolean] filter param to retrieve only free to play champions
    # @return [Array<Lol::DynamicModel>] an array of champions
    def all free_to_play: false
      result = perform_request api_url("champions", "freeToPlay" => free_to_play)
      result["champions"].map { |c| DynamicModel.new c }
    end

    # Retrieve champion by ID
    #
    # See: https://developer.riotgames.com/api-methods/#champion-v3/GET_getChampionsById
    # @param id [Integer] id of the champion to get
    # @return [Lol::DynamicModel] the found champion
    def find id
      result = perform_request api_url "champions/#{id}"
      DynamicModel.new result
    end
  end
end
