module Lol
  class ChampionMastery < Lol::Model
    # @!attribute [r] champion_id
    # @return [Fixnum] id of Champion
    attr_reader :champion_id

    # @!attribute [r] champion_level
    # @return [Fixnum] Level of mastery for this champion
    attr_reader :champion_level

    # @!attribute [r] champion_points
    # @return [Fixnum] Number of mastery points for this champion
    attr_reader :champion_points

    # @!attribute [r] champion_points_since_last_level
    # @return [Fixnum] Number of mastery points since the last level for this champion
    attr_reader :champion_points_since_last_level

    # @!attribute [r] champion_points_until_next_level
    # @return [Fixnum] Number of mastery points until the next level for this champion
    attr_reader :champion_points_until_next_level

    # @!attribute [r] chest_granted
    # @return [true] if the chest for this champion has been granted
    # @return [false] if the chest for this champion has been granted or not in current season
    attr_reader :chest_granted

    # @!attribute [r] highest_grade
    # @return [String] The highest grade of this champion of current season
    attr_reader :highest_grade

    # @!attribute [r] last_play_time
    # @return [Fixnum] Last time this champion was played by this player - in Unix milliseconds time format
    attr_reader :last_play_time

    # @!attribute [r] player_id
    # @return [Fixnum] Player ID for this entry
    attr_reader :player_id

    # @!attribute [r] player_id
    # @return [Fixnum] Number of tokens earned
    attr_reader :tokens_earned

    private

    attr_writer :champion_id, :champion_level, :champion_points, :champion_points_since_last_level,
                :champion_points_until_next_level, :chest_granted, :highest_grade, :last_play_time, :player_id,
                :tokens_earned
  end
end
