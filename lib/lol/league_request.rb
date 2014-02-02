module Lol
  class LeagueRequest < Request
    # Returns the supported API Version
    # @return [String] the supported api version
    def self.api_version
      "v2.3"
    end

    # Retrieves leagues data for summoner, including leagues for all of summoner's teams
    # @param [String]
    # @return [Array]
    def get summoner_id
      perform_request(api_url("league/by-summoner/#{summoner_id}")).map {|l| League.new l}
    end

  end
end
