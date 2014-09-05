module Lol
  class TeamRequest < Request
    # Returns the supported API version
    # @return [String] supported api version
    def self.api_version
      "v2.4"
    end

    # Retrieves the list of Teams for the given summoner
    # @return [Array] List of Team
    def by_summoner *summoner_ids
      returns = {}
      perform_request(api_url "team/by-summoner/#{summoner_ids.join(",")}").each do |s, t|
        returns[s] = []
        t.each do |team|
          returns[s] << Team.new(team)
        end
      end
      returns
    end

    # Retrieves the Teams for the given Team ID
    # @return [Team]
    def get *team_ids
      returns = {}
      perform_request(api_url "team/#{team_ids.join(",")}").each do |t,d|
        returns[t] = Team.new d
      end
      returns
    end
  end
end
