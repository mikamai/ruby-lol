module Lol
  class SummonerRequest < Request
    # Looks for a summoner name and returns the associated summoner
    # @param [String] name Summoner name
    # @return [Summoner] matching summoner
    def by_name name
      Summoner.new perform_request(api_url("v1.1", "summoner/by-name/#{name}"))
    end

    # Get list of summoner names by summoner IDs
    # @param [Array] array of summoner ids
    # @return [Array] array of Hash { "id" => "foo", "name" => "bar" }
    def name *summoner_ids
      perform_request(api_url("v1.1", "summoner/#{summoner_ids.join(",")}/name"))["summoners"].map do |summoner|
        summoner
      end
    end

    # Get summoner by summoner ID
    # @param [String] summoner_id
    # @return [Lol::Summoner]
    def get summoner_id
      Summoner.new perform_request(api_url("v1.1", "summoner/#{summoner_id}"))
    end
  end
end
