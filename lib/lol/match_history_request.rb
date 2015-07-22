module Lol
  class MatchHistoryRequest < Request
    # Returns the supported API Version
    # @return [String] the supported api version
    def self.api_version
      "v2.2"
    end

    # Returns match history for a summoner
    # @return []
    def get summoner_id
      perform_request(api_url("matchhistory/#{summoner_id}"))
    end
  end
end
