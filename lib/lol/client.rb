require 'httparty'
require 'uri'

module Lol
  class InvalidAPIResponse < StandardError; end

  class Client
    include HTTParty

    # @!attribute [rw] region
    #   @return [String] name of region
    attr_accessor :region

    # @!attribute [r] api_key
    #   @return [String] the API key that has been used
    attr_reader :api_key

    # Returns a full url for an API call
    # @param version [String] API version to call
    # @param path [String] API path to call
    # @return [String] full fledged url
    def api_url version, path, params = {}
      lol = version == "v1.1" ? "lol" : ""
      query_string = URI.encode_www_form params.merge api_key: api_key
      File.join "http://prod.api.pvp.net/api/", lol, "/#{region}/#{version}/", "#{path}?#{query_string}"
    end

    # Calls the API via HTTParty and handles errors
    #
    def get url
      response = self.class.get(url)
      if response["status"]
        raise InvalidAPIResponse.new(response["status"]["message"])
      else
        response
      end
    end

    # Calls the latest API version of champion
    def champion
      champion11
    end

    # Retrieve all champions, v1.1
    # @return [Array] an array of champions
    def champion11
      get(api_url("v1.1", "champion"))["champions"].map {|c| Champion.new(c)}
    end

    # Calls the latest API version of game returning the list of
    # recent games played by a summoner
    def game *args
      game11 *args
    end

    # Returns a list of the recent games played by a summoner
    # @param summoner_id [Fixnum] Summoner id
    # @return [Array] an array of games
    def game11 summoner_id
      summoner_api_path = "game/by-summoner/#{summoner_id}/recent"
      get(api_url("v1.1", summoner_api_path))["games"].map do |game_data|
        Game.new game_data
      end
    end

    # Calls the latest API version of league
    def league summoner_id
      league21 summoner_id
    end

    # Retrieves leagues data for summoner, including leagues for all of summoner's teams, v2.1
    # @return [Array] an array of champions
    def league21 summoner_id
      get(api_url("v2.1", "league/by-summoner/#{summoner_id}"))[summoner_id].map {|l| League.new}
    end

    # Calls the latest API version of stats
    def stats *args
      stats11 *args
    end

    # Retrieves player statistics summaries for the given summoner
    # @return [Array] an array of player statistics, one per queue type
    def stats11 summoner_id, extra = {}
      if extra.keys.select { |k| k.to_sym != :season }.any?
        raise ArgumentError, 'Only :season is allowed as extra parameter'
      end
      stats_api_path = "stats/by-summoner/#{summoner_id}/summary"
      get(api_url('v1.1', stats_api_path, extra))['playerStatSummaries'].map do |player_stat_data|
        PlayerStatistic.new player_stat_data
      end
    end

    # Initializes a Lol::Client
    # @param api_key [String]
    # @param options [Hash]
    # @option options [String] :region ("EUW") The region on which the requests will be made
    # @return [Lol::Client]
    def initialize api_key, options = {}
      @api_key = api_key
      @region = options.delete(:region) || "euw"
    end

  end
end
