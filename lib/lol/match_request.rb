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
  end
end
