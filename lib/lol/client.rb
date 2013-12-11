require 'httparty'

module Lol
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
    def api_url version, path
      File.join "http://prod.api.pvp.net/api/lol/#{region}/#{version}/", "#{path}?api_key=#{api_key}"
    end

    # Calls the latest API version of champion
    def champion
      champion11
    end

    # Returns a list of all champions, v1.1
    # @return [Array] an array of champions
    def champion11
      self.class.get(api_url("v1.1", "champion"))["champions"].map {|c| Champion.new(c)}
    end

    # Calls the latest API version of game
    def game summoner_id
      game11 summoner_id
    end

    # Returns a list of the recent games played by a summoner
    # @param summoner_id [Fixnum] Summoner id
    # @return [Array] an array of games
    def game11 summoner_id
      path = "game/by-summoner/#{summoner_id}"
      self.class.get(api_url("v1.1", path))["games"].map do |game_data|
        Game.new game_data
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
