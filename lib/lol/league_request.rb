module Lol
  class LeagueRequest < Request
    # Retrieves leagues data for summoner, including leagues for all of summoner's teams, v2.1
    # @return [Array] an array of champions
    def get summoner_id
      response = perform_request(api_url("v2.1", "league/by-summoner/#{summoner_id}"))[summoner_id.to_s]
      response.is_a?(Hash) ? [League.new(response)] : response.map {|l| League.new l}
    end

  end
end
