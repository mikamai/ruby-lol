module Lol
  class LolStatusRequest < Request

    def self.api_version
      "v1.0"
    end

    def initialize region = nil, cache_store = {}, rate_limiter = nil
      super nil, region, cache_store, rate_limiter
    end

    # Returns a list of each shard status
    # This special call works against all regions
    # @return [Array] an array of DynamicModel representing the response
    def shards
      perform_request(api_url('shards')).map do |shard_data|
        DynamicModel.new shard_data
      end
    end

    # Returns a detailed status of the current shard
    # @return [DynamicModel]
    def current_shard
      shard_data = perform_request(api_url('shards', region))
      DynamicModel.new shard_data
    end

    def api_url path, params = {}
      "http://status.leagueoflegends.com/#{path}".tap do |url|
        url << "/#{params}" unless params.empty?
      end
    end
  end
end
