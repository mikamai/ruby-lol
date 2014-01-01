module Lol
  class TeamRequest < Request
    # Returns the supported API version
    # @return [String] supported api version
    def self.api_version
      "v2.2"
    end

    # Retrieves the list of Teams for the given summoner
    # @return [Array] List of Team
    def get summoner_id
      perform_request(api_url "team/by-summoner/#{summoner_id}").map do |team_data|
        Team.new team_data
      end
    end
  end
end
