module Lol
  # Bindings for the Third Party Code API.
  #
  # See: https://developer.riotgames.com/api-methods/#third-party-code-v3
  class ThirdPartyCodeRequest < Request
    # @!visibility private
    def api_base_path
      "/lol/platform/#{self.class.api_version}"
    end

    # Get the verification string set by the user
    # @param [Integer] id Summoner ID
    # @return [string] Verification code set in User's LoLClient
    def find summoner_id
      perform_request api_url "third-party-code/by-summoner/#{summoner_id}"
    end
  end
end
