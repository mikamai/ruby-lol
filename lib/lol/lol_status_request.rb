module Lol
  class LolStatusRequest < Request

    def self.api_version
      "v1.0"
    end

    def shards
      perform_request(api_url('shards')).map do |shard_data|
        Shard.new shard_data
      end
    end

    def initialize region = nil, cache_store = {}
      super nil, region, cache_store
    end

    def api_url path, params = {}
      "http://status.leagueoflegends.com/#{path}".tap do |url|
        url << "/#{params}" unless params.empty?
      end
    end
  end
end
