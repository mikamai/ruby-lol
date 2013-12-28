module Lol
  class LeagueRequest < Request
    # Returns the supported API Version
    # @return [String] the supported api version
    def self.api_version
      "v2.2"
    end

    # Retrieves leagues data for summoner, including leagues for all of summoner's teams, v2.1
    # @return [Array] an array of champions
    def get summoner_id
      response = perform_request(api_url("league/by-summoner/#{summoner_id}"))[summoner_id.to_s]
      response.is_a?(Hash) ? [League.new(response)] : response.map {|l| League.new l}
    end

  end
end
