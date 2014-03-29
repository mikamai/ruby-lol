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

    # Retrieves leagues entry data for summoner, including league entries for all of summoner's teams
    # @param [String]
    # @return [Array]
    # TODO: Change name to entries?
    def get_entries summoner_id
      perform_request(api_url("league/by-summoner/#{summoner_id}/entry")).map { |e| LeagueEntry.new e }
    end

    # Retrieves leagues data for team
    # @param [String]
    # @return [Array]
    def by_team team_id
      perform_request(api_url("league/by-team/#{team_id}")).map { |l| League.new l }
    end

    # Retrieves leagues entry data for team
    # @param [String]
    # @return [Array]
    # TODO: Change name to?
    def entries_by_team team_id
      perform_request(api_url("league/by-team/#{team_id}/entry")).map { |e| LeagueEntry.new e }
    end

    # Retrieves challenger tier leagues
    # @return [Array]
    def challenger
      perform_request(api_url('league/challenger')).map { |l| League.new l }
    end
  end
end
