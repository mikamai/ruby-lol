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
    # @param [Integer] id Summoner ID
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
    # @param [Integer] account_id Account ID
    # @return [DynamicModel] Summoner representation
    def find_by_account_id account_id
      DynamicModel.new perform_request api_url "summoners/by-account/#{account_id}"
    end
  end
end
