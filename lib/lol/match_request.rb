module Lol
  # Bindings for the Match API.
  #
  # See: https://developer.riotgames.com/api-methods/#match-v3
  class MatchRequest < V3Request
    # @!visibility private
    def api_base_path
      "/lol/match/#{self.class.api_version}"
    end

    # Get match by match ID.
    # @param [Integer] match_id Match ID
    # @param [String] tournament_code Optional tournament code the match belongs to
    # @return [DynamicModel] Match representation
    def find match_id, tournament_code: nil
      url = "matches/#{match_id}".tap do |u|
        u << "/by-tournament-code/#{tournament_code}" if tournament_code
      end
      DynamicModel.new perform_request api_url url
    end

    # Get match timeline by match ID.
    # @param [Integer] match_id Match ID
    # @return [DynamicModel] Timeline represantion
    def find_timeline match_id
      DynamicModel.new perform_request api_url "timelines/by-match/#{match_id}"
    end

    # Get match IDs by tournament code.
    # @param [String] tournament_code Tournament code
    # @return [Array<Integer>] List of match IDs
    def ids_by_tournament_code tournament_code
      perform_request api_url "matches/by-tournament-code/#{tournament_code}/ids"
    end

    # Get matchlist for ranked games played on given account ID and platform ID and filtered using given filter parameters, if any.
    # @param [Integer] account_id Account ID
    # @param [Hash] options the options to pass to the call
    # @option options [Array<Integer>] queue Set of queue IDs for which to filtering matchlist.
    # @option options [Integer] beginTime The begin time to use for filtering matchlist specified as epoch milliseconds.
    # @option options [Integer] endTime The end time to use for filtering matchlist specified as epoch milliseconds.
    # @option options [Integer] beginIndex The begin index to use for filtering matchlist.
    # @option options [Integer] endIndex The end index to use for filtering matchlist.
    # @option options [Array<Integer>] season Set of season IDs for which to filtering matchlist.
    # @option options [Array<Integer>] champion Set of champion IDs for which to filtering matchlist.
    # @return [DynamicModel] MatchList represantion
    def all options={}, account_id:
      DynamicModel.new perform_request api_url "matchlists/by-account/#{account_id}", options
    end

    # Get matchlist for last 20 matches played on given account ID and platform ID.
    # @param [Integer] account_id Account ID
    # @return [DynamicModel] MatchList represantion
    def recent account_id:
      DynamicModel.new perform_request api_url "matchlists/by-account/#{account_id}/recent"
    end

    # Returns a match with the given id
    # @deprecated Please use {MatchRequest#find} instead
    # @param match_id [Integer] Match ID
    # @return [Hash] match object
    def get match_id
      warn_for_deprecation "MatchRequest#get has been deprecated. Use MatchRequest#get instead"
      find(match_id).to_h
    end

    # Returns a match list for the give tournament code
    # @deprecated Please use {MatchRequest#ids_by_tournament_code} instead
    # @param tournament_code [String] Tournament code
    # @return [Array] match ids for the given tournament code
    def by_tournament tournament_code
      warn_for_deprecation "MatchRequest#by_tournament has been deprecated. Use MatchRequest#ids_by_tournament_code instead"
      ids_by_tournament_code tournament_code
    end

    # Returns a match with the given id if is part of the given tournament code
    # @deprecated Please use {MatchRequest#get} instead
    # @param match_id [Integer] Match ID
    # @param tournament_code [String] Tournament code
    # @return [Hash] match object
    def for_tournament match_id, tournament_code
      warn_for_deprecation "MatchRequest#for_tournament(#{match_id}, #{tournament_code}) has been deprecated. Use MatchRequest#find(#{match_id}, tournament_code: #{tournament_code}"
      find(match_id, tournament_code: tournament_code).to_h
    end
  end
end
