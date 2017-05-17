module Lol
  # Bindings for the Status API.
  #
  # See: https://developer.riotgames.com/api-methods/#lol-status-v3
  class LolStatusRequest < V3Request
    # @!visibility private
    def api_base_path
      "/lol/status/#{self.class.api_version}"
    end

    # Get League of Legends status for the given shard
    # @return [DynamicModel]
    def shard_data
      DynamicModel.new perform_request api_url "shard-data"
    end
  end
end
