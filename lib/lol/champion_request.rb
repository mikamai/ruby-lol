module Lol
  class ChampionRequest < Request
    # Returns the supported API Version
    # @return [String] the supported api version
    def self.api_version
      "v1.1"
    end

    # Retrieve all champions, v1.1
    # @return [Array] an array of champions
    def get
      perform_request(api_url("champion"))["champions"].map {|c| Champion.new(c)}
    end

  end
end
