module Lol
  class TeamRequest < Request
    # Retrieves the list of Teams for the given summoner
    # @return [Array] List of Team
    def get summoner_id
      perform_request(api_url 'v2.1', "team/by-summoner/#{summoner_id}").map do |team_data|
        Team.new team_data
      end
    end
  end
end
