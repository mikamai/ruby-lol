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
      escaped_names = names.flatten.map { |name| CGI.escape name }
      perform_request(api_url("summoner/by-name/#{escaped_names.join(",")}")).map do |key, data|
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
      extract_pages RunePage, "runes", summoner_ids
    end

    # Get mastery pages by summoner ID
    # @param [Array] summoner_ids
    # @return [Array] array of Lol::MasteryPage
    def masteries *summoner_ids
      extract_pages MasteryPage, "masteries", summoner_ids
    end

    private

    # Extract pages by summoner ID
    # @param klass [Class] class used to instance objects in arrays
    # @param page_type [String] path of the request
    # @param *summoner_ids [Array] array of summoner_ids
    def extract_pages klass, page_type, *summoner_ids
      perform_request(api_url("summoner/#{summoner_ids.join(",")}/#{page_type}")).inject({}) do |ack, data|
        ack[data.first] = data.last["pages"].map {|m| klass.new m}
        ack
      end
    end
  end
end
