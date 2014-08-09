module Lol
  # Holds the representation of a League
  class LeagueEntry < Model
    # @!attribute [r] division
    # @return [String] the league division of the participant
    attr_reader :division

    # @!attribute [r] is_fresh_blood
    # @return [Boolean] is fresh blood in this league
    attr_reader :is_fresh_blood

    # @!attribute [r] is_hot_streak
    # @return [Boolean] is currently on hot streak
    attr_reader :is_hot_streak

    # @!attribute [r] is_inactive
    # @return [Boolean] is marked as inactive
    attr_reader :is_inactive

    # @!attribute [r] is_veteran
    # @return [Boolean] is a veteran in this league
    attr_reader :is_veteran

    # @!attribute [r] league_points
    # @return [String] league points of entry
    attr_reader :league_points

    # @!attribute [r] mini_series
    # @return [MiniSeries] if player is in a mini_series, returns the MiniSeries object
    #           representing it
    attr_reader :mini_series

    # @!attribute [r] player_or_team_id
    # @return [String] id for the player or the team returned
    attr_reader :player_or_team_id

    # @!attribute [r] player_or_team_name
    # @return [String] name for the player or the team returned
    attr_reader :player_or_team_name

    # @!attribute [r] wins
    # @return [String] wins
    attr_reader :wins

    # @!attribute [r] last_played
    # @return [DateTime] date of last played game
    #           at the time of writing this attributes is broken in the API
    #           it always returns 0.
    attr_reader :last_played

    # @!attribute [r] time_until_decay
    # @return [Boolean] time until league decay
    attr_reader :time_until_decay

    private

    attr_writer :player_or_team_id, :player_or_team_name, :division, :league_points, :wins,
                :is_hot_streak, :is_veteran, :is_fresh_blood,
                :is_inactive, :time_until_decay, :last_played

    def mini_series= raw
      @mini_series = MiniSeries.new raw
    end

  end
end
