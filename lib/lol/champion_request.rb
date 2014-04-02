module Lol
  class ChampionRequest < Request
    # Returns the supported API Version
    # @return [String] the supported api version
    def self.api_version
      "v1.2"
    end

    # Retrieve all champions
    # @param [Hash] options the options to pass to the call
    # @option options [Fixnum] :id the champion to get. If nil gets all champions
    # @option options [Boolean] :free_to_play filters for free to play champions
    # @return [Array] an array of champions
    def get options = {}

      champion_id = options.delete :id
      free_to_play = options.delete(:free_to_play) ? true : false

      url = champion_id ? "champion/#{champion_id}" : "champion"
      result = perform_request(api_url(url, "freeToPlay" => free_to_play))

      if champion_id
        Champion.new(result)
      else
        result["champions"].map {|c| Champion.new(c)}
      end
    end

  end
end
