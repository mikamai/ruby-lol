module Lol
  class MatchRequest < Request
    # Returns the supported API Version
    # @return [String] the supported api version
    def self.api_version
      "v2.2"
    end

    # Returns a match with the given id
    # @param match_id [Fixnum] Match ID
    # @return [Hash] match object
    def get match_id
      perform_request(api_url("match/#{match_id}"))
    end

    # Returns a match list for the give tournament code
    # @param tournament_code [String] Tournament code
    # @return [Array] match ids for the given tournament code
    def by_tournament tournament_code
      perform_request(api_url("match/by-tournament/#{tournament_code}/ids"))
    end

    # Returns a match with the given id if is part of the given tournament code
    # @param match_id [Fixnum] Match ID
    # @param tournament_code [String] Tournament code
    # @return [Hash] match object
    def for_tournament match_id, tournament_code
      perform_request(api_url("match/for-tournament/#{match_id}?tournamentCode=#{tournament_code}"))
    end
  end
end
