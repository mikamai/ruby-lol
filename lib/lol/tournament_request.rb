module Lol
  class TournamentRequest < V3Request
    # @!visibility private
    def api_base_path
      "/lol/tournament/#{self.class.api_version}"
    end

    # @!visibility private
    def api_base_url
      "https://global.api.riotgames.com"
    end

    # Creates a tournament provider and returns its ID.
    # @param [String] url The provider's callback URL to which tournament game results in this region should be posted. The URL must be well-formed, use the http or https protocol, and use the default port for the protocol
    # @return [Integer] Provider ID
    def create_provider url:
      body = {
        "url"    => url,
        "region" => region.upcase
      }
      perform_request api_url("providers"), :post, body
    end

    # Creates a tournament and returns its ID.
    # @param [Integer] provider_id The provider ID to specify the regional registered provider data to associate this tournament.
    # @param [String] name Name of the tournament
    # @return [Integer] Tournament ID
    def create_tournament provider_id:, name: nil
      body = {
        "providerId" => provider_id,
        "name"       => name
      }.compact
      perform_request api_url("tournaments"), :post, body
    end

    # Create a tournament code for the given tournament.
    # @param [Integer] count The number of codes to create (max 1000)
    # @param [Integer] tournament_id The tournament ID
    # @param [String] spectator_type The spectator type of the game. Valid values are NONE, LOBBYONLY, ALL.
    # @param [Integer] team_size The team size of the game. Valid values are 1-5.
    # @param [String] pick_type The pick type of the game. Valid values are BLIND_PICK, DRAFT_MODE, ALL_RANDOM, TOURNAMENT_DRAFT.
    # @param [String] map_type The map type of the game. Valid values are SUMMONERS_RIFT, TWISTED_TREELINE, CRYSTAL_SCAR, and HOWLING_ABYSS.
    # @param [Array<Integer>] allowed_participants List of participants in order to validate the players eligible to join the lobby.
    # @param [String] metadata Optional string that may contain any data in any format, if specified at all. Used to denote any custom information about the game.
    # @return [Array<String>] generated tournament codes
    def create_codes tournament_id:, count: nil, allowed_participants: nil,
                       map_type: "SUMMONERS_RIFT", metadata: nil, team_size: 5,
                       pick_type: "TOURNAMENT_DRAFT", spectator_type: "ALL"
      body = {
        "allowedParticipants" => allowed_participants,
        "mapType"             => map_type,
        "metadata"            => metadata,
        "pickType"            => pick_type,
        "spectatorType"       => spectator_type,
        "teamSize"            => team_size
      }.compact
      uri_params = {
        "tournamentId" => tournament_id,
        "count"        => count
      }.compact
      perform_request api_url("codes", uri_params), :post, body
    end

    # Update the pick type, map, spectator type, or allowed summoners for a code.
    # @param [String] tournament_code The tournament code to update
    # @param [Array<Integer>] allowed_participants List of participants in order to validate the players eligible to join the lobby.
    # @param [String] map_type The map type of the game. Valid values are SUMMONERS_RIFT, TWISTED_TREELINE, CRYSTAL_SCAR, and HOWLING_ABYSS.
    # @param [String] pick_type The pick type of the game. Valid values are BLIND_PICK, DRAFT_MODE, ALL_RANDOM, TOURNAMENT_DRAFT.
    # @param [String] spectator_type The spectator type of the game. Valid values are NONE, LOBBYONLY, ALL.
    def update_code tournament_code, allowed_participants: nil, map_type: nil, pick_type: nil, spectator_type: nil
      body = {
        "allowedParticipants" => allowed_participants,
        "mapType"             => map_type,
        "pickType"            => pick_type,
        "spectatorType"       => spectator_type
      }.compact
      perform_request api_url("codes/#{tournament_code}"), :put, body
    end

    # Returns the tournament code details
    # @param [String] tournament_code the tournament code string
    # @return [DynamicModel] A tournament code representation
    def find_code tournament_code
      DynamicModel.new perform_request api_url "codes/#{tournament_code}"
    end

    # Gets a list of lobby events by tournament code
    # @param [String] tournament_code the tournament code string
    # @return [Array<DynamicModel>] List of lobby events
    def all_lobby_events tournament_code:
      result = perform_request api_url "lobby-events/by-code/#{tournament_code}"
      result["eventList"].map { |e| DynamicModel.new e }
    end

    # Returns a tournament code
    # @deprecated Please use {TournamentRequest#create_codes} instead
    # @param tournament_id [Integer] Tournament ID
    # @param count [Integer] Number of tournament codes to generate
    # @param options [Hash] Tournament Code options hash
    # @option options [Integer] :team_size Team Size 1-5
    # @option options [Array] :allowed_participants SummonerIds spec
    # @option options [String] :game_lobby_name Not used for now
    # @option options [String] :spectator_type NONE, LOBBYONLY, ALL
    # @option options [String] :password Game Lobby password, mandatory
    # @option options [String] :pick_type BLIND_PICK, DRAFT_MODE, ALL_RANDOM, TOURNAMENT_DRAFT
    # @option options [String] :map_type SUMMONERS_RIFT, CRYSTAL_SCAR, HOWLING_ABYSS
    # @option options [String] :metadata Optional metadata String
    def code tournament_id, count = 1, options = {}
      team_size = options.delete(:team_size) || 5
      allowed_participants = options.delete(:allowed_participants)
      game_lobby_name = options.delete(:game_lobby_name) || "Lobby"
      spectator_type = options.delete(:spectator_type) || "ALL"
      password = options.delete(:password)
      pick_type = options.delete(:pick_type) || "TOURNAMENT_DRAFT"
      map_type = options.delete(:map_type) || "SUMMONERS_RIFT"
      metadata = options.delete(:metadata)

      warn_for_deprecation "TournamentRequest#code has been deprecated. Use TournamentRequest#create_codes instead"
      create_codes({
        :tournament_id        => tournament_id,
        :count                => count,
        :allowed_participants => allowed_participants,
        :spectator_type       => spectator_type,
        :map_type             => map_type,
        :pick_type            => pick_type,
        :metadata             => metadata,
        :team_size            => team_size
      })
    end

    # Returns the details of the tournament code
    # @deprecated Please use {TournamentRequest#find_code} instead
    # @param tournament_code [String] Tournament code
    def get_code tournament_code
      warn_for_deprecation "TournamentRequest#get_code has been deprecated. Use TournamentRequest#find_code instead"
      find_code(tournament_code)
    end

    # @deprecated Please use {TournamentRequest#create_provider} instead
    def provider region, url
      warn_for_deprecation "TournamentRequest#provider has been deprecated. Use TournamentRequest#create_provider instead"
      create_provider url: url
    end

    # @deprecated Please use {TournamentRequest#create_tournament} instead
    def tournament name, provider
      warn_for_deprecation "TournamentRequest#tournament has been deprecated. Use TournamentRequest#create_tournament instead"
      create_tournament provider_id: provider, name: name
    end
  end
end
