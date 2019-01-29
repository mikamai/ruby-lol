module Lol
  # Bindings for the Summoner API.
  #
  # See: https://developer.riotgames.com/api-methods/#summoner-v4
  class SummonerRequest < Request
    # @!visibility private
    def api_base_path
      "/lol/summoner/#{self.class.api_version}"
    end

    # Get a summoner by encrypted summoner ID.
    # @param [String] encrypted id Summoner ID
    # @return [DynamicModel] Summoner representation
    def find encrypted_id
      DynamicModel.new perform_request api_url "summoners/#{encrypted_id}"
    end

    # Get a summoner by summoner name.
    # @param [String] name Summoner name
    # @return [DynamicModel] Summoner representation
    def find_by_name name
      name = CGI.escape name.downcase.gsub(/\s/, '')
      DynamicModel.new perform_request api_url "summoners/by-name/#{name}"
    end

    # Get a summoner by encrypted account ID.
    # @param [String] account_id encrypted Account ID
    # @return [DynamicModel] Summoner representation
    def find_by_account_id encrypted_account_id
      DynamicModel.new perform_request api_url "summoners/by-account/#{encrypted_account_id}"
    end

    # Get a summoner by encrypted PUUID.
    # @param [String] account_id encrypted PUUID
    # @return [DynamicModel] Summoner representation
    def find_by_puuid encrypted_puuid
      DynamicModel.new perform_request api_url "summoners/by-puuid/#{encrypted_puuid}"
    end
  end
end
