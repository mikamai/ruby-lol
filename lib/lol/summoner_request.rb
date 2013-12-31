module Lol
  class SummonerRequest < Request
    # Returns the supported API Version
    # @return [String] the supported api version
    def self.api_version
      "v1.2"
    end

    # Looks for a summoner name and returns the associated summoner
    # @param [String] name Summoner name
    # @return [Summoner] matching summoner
    def by_name name
      Summoner.new perform_request(api_url("summoner/by-name/#{name}"))
    end

    # Get list of summoner names by summoner IDs
    # @param [Array] summoner_ids array of summoner ids
    # @return [Array] array of Hash { "id" => "foo", "name" => "bar" }
    def name *summoner_ids
      perform_request(api_url("summoner/#{summoner_ids.join(",")}/name"))["summoners"].map do |summoner|
        summoner
      end
    end

    # Get summoner by summoner ID
    # @param [String] summoner_id
    # @return [Lol::Summoner]
    def get summoner_id
      Summoner.new perform_request(api_url("summoner/#{summoner_id}"))
    end

    # Get rune pages by summoner ID
    # @param [String] summoner_id
    # @return [Array] array of Lol::RunePage
    def runes summoner_id
      perform_request(api_url("summoner/#{summoner_id}/runes"))["pages"].map do |runepage|
        RunePage.new runepage
      end
    end

    # Get mastery pages by summoner ID
    # @param [String] summoner_id
    # @return [Array] array of Lol::MasteryPage
    def masteries summoner_id
      perform_request(api_url("summoner/#{summoner_id}/masteries"))["pages"].map do |masterypage|
        MasteryPage.new masterypage
      end
    end

  end
end
