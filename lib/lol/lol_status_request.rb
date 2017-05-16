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

    # Returns a detailed status of the current shard
    # @deprecated Please use {LolStatusRequest#shard_data} instead
    # @return [DynamicModel]
    def current_shard
      warn_for_deprecation "LolStatusRequest#current_shard has been deprecated. Use LolStatusRequest#shard_data instead"
      shard_data
    end
  end
end
