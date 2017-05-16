module Lol
  # This object exposes ChampionMasteryDTO properties, returned by champion-mastery-related requests,
  # as accessors.
  #
  # See: https://developer.riotgames.com/api-methods/#champion-mastery-v3
  class ChampionMastery < DynamicModel
    # @!attribute chest_granted
    #	  @return [true|false] Is chest granted for this champion or not in current season
    # @!attribute champion_level
    #	  @return [Integer] Champion level for specified player and champion combination.
    # @!attribute champion_points
    #	  @return [Integer] Total number of champion points for this player and champion combination - they are used to determine championLevel.
    # @!attribute champion_id
    #	  @return [Integer] Champion ID for this entry.
    # @!attribute player_id
    #	  @return [Integer] Player ID for this entry.
    # @!attribute champion_points_until_next_level
    #	  @return [Integer] Number of points needed to achieve next level. Zero if player reached maximum champion level for this champion.
    # @!attribute champion_points_since_last_level
    #	  @return [Integer] Number of points earned since current level has been achieved. Zero if player reached maximum champion level for this champion.
    # @!attribute last_play_time
    #	  @return [Integer] Last time this champion was played by this player - in Unix milliseconds time format.
  end
end
