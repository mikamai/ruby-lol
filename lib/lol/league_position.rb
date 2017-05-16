module Lol
  # This object exposes LeaguePositionDTO properties, returned by league-related requests,
  # as accessors.
  #
  # See: https://developer.riotgames.com/api-methods/#league-v3
  class LeaguePosition < DynamicModel
    # @!attribute rank
    #   @return [String] Rank identifier

    # @!attribute queue_type
    #   @return [String] Queue type

    # @!attribute hot_streak
    #   @return [true|false] Whether Hot Streak promotions are active

    # @!attribute mini_series
    #   @return [MiniSeries] if player or team is in a mini_series, returns the MiniSeries representation

    # @!attribute wins
    #   @return [Integer] Number of wins

    # @!attribute veteran
    #   @return [true|false] if the player or team is veteran in this league

    # @!attribute losses
    #   @return [Integer] Number of losses

    # @!attribute player_or_team_id
    #   @return [String] Player or team identifier

    # @!attribute league_name
    #   @return [String] League Name

    # @!attribute player_or_team_name
    #   @return [String] Player or team name

    # @!attribute inactive
    #   @return [true|false] if the player or team is inactive

    # @!attribute fresh_blood
    #   @return [true|false] if the player or team is fresh blood in this league

    # @!attribute tier
    #   @return [String] Tier name

    # @!attribute league_points
    #   @return [Integer] number of league points

    protected

    # @!visibility private
    def class_for_property property
      case property
      when :mini_series then MiniSeries
      else super
      end
    end
  end
end
