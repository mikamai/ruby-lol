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
    def get *summoner_ids
      perform_request(api_url("league/by-summoner/#{summoner_ids.join(",")}")).each_with_object({}) do |(s, l), returns|
        returns[s] = l.map {|data| League.new data}
      end
    end

    # Retrieves leagues entry data for summoner, including league entries for all of summoner's teams
    # @param [Array<String>]
    # @return [Array]
    # TODO: Change name to entries?
    def get_entries *summoner_ids
      perform_request(api_url("league/by-summoner/#{summoner_ids.join(',')}/entry")).map { |e| LeagueEntry.new e }
    end

    # Retrieves leagues data for team
    # @param [Array<String>]
    # @return [Array]
    def by_team *team_ids
      perform_request(api_url("league/by-team/#{team_ids.join(',')}")).map { |l| League.new l }
    end

    # Retrieves leagues entry data for team
    # @param [Array<String>]
    # @return [Array]
    # TODO: Change name to?
    def entries_by_team *team_ids
      perform_request(api_url("league/by-team/#{team_ids.join(',')}/entry")).map { |e| LeagueEntry.new e }
    end

    # Retrieves challenger tier leagues
    # @return [Array]
    def challenger
      perform_request(api_url('league/challenger')).map { |l| League.new l }
    end
  end
end
