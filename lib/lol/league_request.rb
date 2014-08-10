module Lol
  class LeagueRequest < Request
    # Returns the supported API Version
    # @return [String] the supported api version
    def self.api_version
      "v2.4"
    end

    # Retrieves leagues data for summoner, including leagues for all of summoner's teams
    # @param [Array<String>]
    # @return Hash{String => Array<League>}
    def get(*summoner_ids)
      perform_league_request("league/by-summoner/#{summoner_ids.join(",")}")
    end

    # Retrieves leagues entry data for summoner, including league entries for all of summoner's teams
    # @param [Array<String>]
    # @return Hash{String => Array<League>}
    # TODO: Change name to entries?
    def get_entries(*summoner_ids)
      perform_league_request("league/by-summoner/#{summoner_ids.join(',')}/entry")
    end

    # Retrieves leagues data for team
    # @param [Array<String>]
    # @return Hash{String => Array<League>}
    def by_team(*team_ids)
      perform_league_request("league/by-team/#{team_ids.join(',')}")
    end

    # Retrieves leagues entry data for team
    # @param [Array<String>]
    # @return Hash{String => Array<League>}
    # TODO: Change name to?
    def entries_by_team(*team_ids)
      perform_league_request("league/by-team/#{team_ids.join(',')}/entry")
    end

    # Retrieves challenger tier leagues
    # @return [League]
    def challenger
      league_json = perform_request(api_url('league/challenger'))
      League.new(league_json)
    end

  private

    def perform_league_request(partial_url)
      url = api_url(partial_url)
      perform_request(url).each_with_object({}) do |(summoner_id, leagues), entries_hash|
        entries_hash[summoner_id] = leagues.map(&League.method(:new))
      end
    end

  end
end
