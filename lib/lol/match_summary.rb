require 'lol/model'

module Lol
  class MatchSummary < Lol::Model
    # @!attribute [r] assists
    # @return [Integer] Number of assists
    attr_reader :assists

    # @!attribute [r] date
    # @return [Time] Match date
    attr_reader :date

    # @!attribute [r] deaths
    # @return [Integer] Number of deaths
    attr_reader :deaths

    # @!attribute [r] game_id
    # @return [Integer] Game Id
    attr_reader :game_id

    # @!attribute [r] game_mode
    # @return [String] Game Mode
    attr_reader :game_mode

    # @!attribute [r] invalid
    # @return [true] If the match is invalid
    # @return [false] If the match is valid
    attr_reader :invalid

    # @!attribute [r] kills
    # @return [Integer] Number of kills
    attr_reader :kills

    # @!attribute [r] map_id
    # @return [Integer] Map Id
    attr_reader :map_id

    # @!attribute [r] opposing_team_kills
    # @return [Integer] Opposing Team Kills
    attr_reader :opposing_team_kills

    # @!attribute [r] opposing_team_name
    # @return [String] Opposing Team Name
    attr_reader :opposing_team_name

    # @!attribute [r] win
    # @return [true] If the team won this match
    # @return [false] If the team lost this match
    attr_reader :win

    private

    attr_writer :assists, :deaths, :game_id, :game_mode, :invalid, :kills, :map_id, :opposing_team_kills, :opposing_team_name, :win

    def date= value
      @date = value.is_a?(Numeric) && Time.at(value / 1000) || value
    end
  end
end
