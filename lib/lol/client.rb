require 'httparty'
require 'uri'

module Lol
  class InvalidAPIResponse < StandardError; end

  class Client

    # @!attribute [rw] region
    #   @return [String] name of region
    attr_accessor :region

    # @!attribute [r] api_key
    #   @return [String] the API key that has been used
    attr_reader :api_key

    # @return [ChampionRequest]
    def champion
      @champion_request ||= ChampionRequest.new(api_key, region)
    end

    # @return [GameRequest]
    def game
      @game_request ||= GameRequest.new(api_key, region)
    end

    # @return [StatsRequest]
    def stats
      @stats_request ||= StatsRequest.new(api_key, region)
    end

    # @return [LeagueRequest]
    def league
      @league_request ||= LeagueRequest.new(api_key, region)
    end

    # @return [TeamRequest]
    def team
      @team_request ||= TeamRequest.new(api_key, region)
    end

    # Retrieves leagues data for summoner, including leagues for all of summoner's teams, v2.1
    # @return [Array] an array of champions
    def league21 summoner_id
      response = get(api_url("v2.1", "league/by-summoner/#{summoner_id}"))[summoner_id]
      response.is_a?(Hash) ? [League.new(response)] : response.map {|l| League.new l}
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
