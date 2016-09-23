module Lol
  class TournamentProviderRequest < Request
    # Returns the supported API Version
    # @return [String] the supported api version
    def self.api_version
      "v1"
    end

    def api_base_url
      "https://global.api.pvp.net"
    end

    # Returns a full url for an API call
    # @param path [String] API path to call
    # @return [String] full fledged url
    def api_url path, params = {}
      url = "#{api_base_url}/tournament/public/#{self.class.api_version}/#{path}"
    end

    def tournament_request path, body
      pau = post_api_url path
      perform_request(pau[:url], :post, body, pau[:options])
    end

    # Returns a tournament code
    # @param tournament_id [Integer] Tournament ID
    # @param count [Integer] Number of tournament codes to generate
    # @param options [Hash] Tournament Code options hash
    # @option options [Integer] :team_size Team Size 1-5
    # @option options [Array] :allowed_summoner_ids SummonerIds spec
    # @option options [String] :game_lobby_name Not used for now
    # @option options [String] :spectator_type NONE, LOBBYONLY, ALL
    # @option options [String] :password Game Lobby password, mandatory
    # @option options [String] :pick_type BLIND_PICK, DRAFT_MODE, ALL_RANDOM, TOURNAMENT_DRAFT
    # @option options [String] :map_type SUMMONERS_RIFT, CRYSTAL_SCAR, HOWLING_ABYSS
    # @option options [String] :metadata Optional metadata String
    def code tournament_id, count = 1, options = {}
      team_size = options.delete(:team_size) || 5
      allowed_summoner_ids = options.delete(:allowed_summoner_ids)
      game_lobby_name = options.delete(:game_lobby_name) || "Lobby"
      spectator_type = options.delete(:spectator_type) || "ALL"
      password = options.delete(:password)
      pick_type = options.delete(:pick_type) || "TOURNAMENT_DRAFT"
      map_type = options.delete(:map_type) || "SUMMONERS_RIFT"
      metadata = options.delete(:metadata)

      body = {
        teamSize: team_size,
        gameLobbyName: game_lobby_name,
        spectatorType: spectator_type,
        pickType: pick_type,
        mapType: map_type
      }

      body.merge!({allowedSummonerIds: allowed_summoner_ids}) if allowed_summoner_ids
      body.merge!({metadata: metadata}) if metadata
      body.merge!({password: password}) if password

      params = URI.encode_www_form({tournamentId: tournament_id, count: count})
      tournament_request "code?#{params}", body
    end

    # Returns the details of the tournament code
    # @param tournament_code [String] Tournament code
    def get_code tournament_code
      TournamentCode.new perform_request(api_url("code/#{tournament_code}?#{api_query_string}"))
    end

    # Returns the updated tournament code
    # @param tournament_code [String] Tournament Code
    # @param options [Hash] Tournament Code options hash
    # @option options [Array] :allowed_participants Array of allowed summoner ids (minimum 10)
    # @option options [String] :pick_type BLIND_PICK, DRAFT_MODE, ALL_RANDOM, TOURNAMENT_DRAFT
    # @option options [String] :map_type SUMMONERS_RIFT, CRYSTAL_SCAR, HOWLING_ABYSS
    # @option options [String] :spectator_type NONE, LOBBYONLY, ALL
    def update_code tournament_code, options = {}
      allowed_participants = options.delete(:allowed_participants) || nil
      allowed_participants = allowed_participants.join(",") unless allowed_participants.nil?
      pick_type = options.delete(:pick_type) || nil
      map_type = options.delete(:map_type) || nil
      spectator_type = options.delete(:spectator_type) || nil

      body = {
        allowedParticipants: allowed_participants ,
        spectatorType: spectator_type,
        pickType: pick_type,
        mapType: map_type
      }.reject{ |k,v| v.nil? }

      pau = post_api_url "code/#{tournament_code}"
      perform_request(pau[:url], :put, body, pau[:options])
      get_code tournament_code
    end

    def provider region, url
      tournament_request "provider", {region: region, url: url}
    end

    def tournament name, provider
      tournament_request "tournament", {name: name, providerId: provider}
    end

    # Returns a list of the recent games played by a summoner
    # @param summoner_id [Fixnum] Summoner id
    # @return [Array] an array of games
    def recent summoner_id
      summoner_api_path = "game/by-summoner/#{summoner_id}/recent"
      perform_request(api_url(summoner_api_path))["games"].map do |game_data|
        Game.new game_data
      end
    end
  end
end
