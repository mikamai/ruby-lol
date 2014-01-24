module Lol
  class SummonerRequest < Request
    # Returns the supported API Version
    # @return [String] the supported api version
    def self.api_version
      "v1.3"
    end

    # Looks for a summoner name and returns the associated summoner
    # @param [Array] summoner names
    # @return [Array] matching summoners
    def by_name *names
      perform_request(api_url("summoner/by-name/#{names.join(",")}")).map do |key, data|
        Summoner.new data
      end
    end

    # Get list of summoner names by summoner IDs
    # @param [Array] summoner_ids
    # @return [Hash] Hash in the form { "id" => "name" }
    def name *summoner_ids
      perform_request(api_url("summoner/#{summoner_ids.join(",")}/name"))
    end

    # Get a list of summoners by summoner ID
    # @param [Array] summoner_ids
    # @return [Array] matching summoners
    def get *summoner_ids
      perform_request(api_url("summoner/#{summoner_ids.join(",")}")).map do |key, data|
        Summoner.new data
      end
    end

    # Get rune pages by summoner ID
    # @param [Array] summoner_ids
    # @return [Array] array of Lol::RunePage
    def runes *summoner_ids
      perform_request(api_url("summoner/#{summoner_ids.join(",")}/runes")).inject({}) do |ack, data|
        ack[data.first] = data.last["pages"].map {|m| RunePage.new m}
        ack
      end
    end

    # Get mastery pages by summoner ID
    # @param [Array] summoner_ids
    # @return [Array] array of Lol::MasteryPage
    def masteries *summoner_ids
      perform_request(api_url("summoner/#{summoner_ids.join(",")}/masteries")).inject({}) do |ack, data|
        ack[data.first] = data.last["pages"].map {|m| MasteryPage.new m}
        ack
      end
    end

  end
end
