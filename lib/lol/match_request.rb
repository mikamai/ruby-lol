module Lol
  # Bindings for the Match API.
  #
  # See: https://developer.riotgames.com/api-methods/#match-v4
  class MatchRequest < Request
    # @!visibility private
    def api_base_path
      "/lol/match/#{self.class.api_version}"
    end

    # Get match by match ID.
    # @param [Integer] match_id Match ID
    # @option options [Integer] forAccountId Optional used to identify the participant to be unobfuscated
    # @option options [Integer] forPlatformId Optional used to identify the participant to be unobfuscated (for when user have changed regions)
    # @return [DynamicModel] Match representation
    def find options={}, match_id:
      DynamicModel.new perform_request api_url "matches/#{match_id}", options
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

    # Get match by match ID and tournament code.
    # @param [Integer] match_id Match ID
    # @param [String] tournament_code Tournament code the match belongs to
    # @return [DynamicModel] Match representation
    def find_by_tournament match_id, tournament_code
      DynamicModel.new perform_request api_url "matches/#{match_id}/by-tournament-code/#{tournament_code}"
    end

    # Get matchlist for ranked games played on given encrypted account ID and platform ID and filtered using given filter parameters, if any.
    # @param [Integer] encrypted_account_id Encrypted Account ID
    # @param [Hash] options the options to pass to the call
    # @option options [Array<Integer>] queue Set of queue IDs for which to filtering matchlist.
    # @option options [Integer] beginTime The begin time to use for filtering matchlist specified as epoch milliseconds.
    # @option options [Integer] endTime The end time to use for filtering matchlist specified as epoch milliseconds.
    # @option options [Integer] beginIndex The begin index to use for filtering matchlist.
    # @option options [Integer] endIndex The end index to use for filtering matchlist.
    # @option options [Array<Integer>] season Set of season IDs for which to filtering matchlist.
    # @option options [Array<Integer>] champion Set of champion IDs for which to filtering matchlist.
    # @return [DynamicModel] MatchList represantion
    def all options={}, encrypted_account_id:
      DynamicModel.new perform_request api_url "matchlists/by-account/#{encrypted_account_id}", options
    end

    # Get matchlist for last 20 matches played on given encrypted account ID and platform ID.
    # @param [Integer] encrypted_account_id Encrypted Account ID
    # @return [DynamicModel] MatchList represantion
    def recent encrypted_account_id:
      DynamicModel.new perform_request api_url "matchlists/by-account/#{encrypted_account_id}/recent"
    end
  end
end
