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

    # Calls the latest API version of champion
    def champion
      @champion_request ||= ChampionRequest.new(api_key, region)
    end

    # Calls the latest API version of game returning the list of
    # recent games played by a summoner
    def game
      @game_request ||= GameRequest.new(api_key, region)
    end

    # Calls the latest API version of league
    def league summoner_id
      league21 summoner_id
    end

    # Retrieves leagues data for summoner, including leagues for all of summoner's teams, v2.1
    # @return [Array] an array of champions
    def league21 summoner_id
      response = get(api_url("v2.1", "league/by-summoner/#{summoner_id}"))[summoner_id]
      response.is_a?(Hash) ? [League.new(response)] : response.map {|l| League.new l}
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

    # Calls the latest API version of ranked_stats
    def ranked_stats *args
      ranked_stats11 *args
    end

    # Retrieves ranked statistics summary for the given summoner
    # @return [RankedStatisticsSummary] Ranked Stats.
    #   Includes stats for Twisted Treeline and Summoner's Rift
    def ranked_stats11 summoner_id, extra = {}
      if extra.keys.select { |k| k.to_sym != :season }.any?
        raise ArgumentError, 'Only :season is allowed as extra parameter'
      end
      stats_api_path = "stats/by-summoner/#{summoner_id}/ranked"
      RankedStatisticsSummary.new get api_url 'v1.1', stats_api_path, extra
    end

    # Calls the latest API version of team returning the list of teams for the given summoner
    def team *args
      team21 *args
    end

    # Retrieves the list of Teams for the given summoner
    # @return [Array] List of Team
    def team21 summoner_id
      get(api_url 'v2.1', "team/by-summoner/#{summoner_id}").map do |team_data|
        Team.new team_data
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
