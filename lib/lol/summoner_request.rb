module Lol
  # Bindings for the Summoner API.
  #
  # See: https://developer.riotgames.com/api-methods/#summoner-v3
  class SummonerRequest < V3Request
    # @!visibility private
    def api_base_path
      "/lol/summoner/#{self.class.api_version}"
    end

    # Get a summoner by summoner ID.
    # @param [Fixnum] id Summoner ID
    # @return [DynamicModel] Summoner representation
    def find id
      DynamicModel.new perform_request api_url "summoners/#{id}"
    end

    # Get a summoner by summoner name.
    # @param [String] name Summoner name
    # @return [DynamicModel] Summoner representation
    def find_by_name name
      name = CGI.escape name.downcase.gsub(/\s/, '')
      DynamicModel.new perform_request api_url "summoners/by-name/#{name}"
    end

    # Get a summoner by account ID.
    # @param [Fixnum] account_id Account ID
    # @return [DynamicModel] Summoner representation
    def find_by_account_id account_id
      DynamicModel.new perform_request api_url "summoners/by-account/#{account_id}"
    end

    # Looks for a summoner name and returns the associated summoner
    # @deprecated Please use {SummonerRequest#find_by_name} instead
    # @param [Array] summoner names
    # @return [Array] matching summoners
    def by_name *names
      warn_for_deprecation "SummonerRequest#by_name has been deprecated. Use SummonerRequest#find_by_name on each name instead"
      names.map { |n| find_by_name n }
    end

    # Get list of summoner names by summoner IDs
    # @deprecated Please use {SummonerRequest#find} instead
    # @param [Array] summoner_ids
    # @return [Hash] Hash in the form { "id" => "name" }
    def name *summoner_ids
      warn_for_deprecation "SummonerRequest#name has been deprecated. Use SummonerRequest#find(id).name on each id instead"
      summoner_ids.inject({}) do |memo, id|
        memo.update id => find(id).name
      end
    end

    # Get a list of summoners by summoner ID
    # @param [Array] summoner_ids
    # @return [Array] matching summoners
    def get *summoner_ids
      warn_for_deprecation "SummonerRequest#get has been deprecated. Use SummonerRequest#find(id) on each id instead"
      summoner_ids.map { |id| find id }
    end
  end
end
