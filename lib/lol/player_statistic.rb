require 'lol/model'

module Lol
  class PlayerStatistic < Lol::Model
    # @!attribute [r] aggregated_stats
    #   @return [Array] List of aggregated statistics
    attr_reader :aggregated_stats

    # @!attribute [r] losses
    #   @return [Fixnum] Number of losses for this queue type. It's presed only for ranked queue types
    attr_reader :losses

    # @!attribute [r] modify_date
    #   @return [Time] Date stat was last modified
    attr_reader :modify_date

    # @!attribute [r] modify_date_str
    #   @return [String] Human readable string representing date stat was last modified
    attr_reader :modify_date_str

    # @!attribute [r] player_stat_summary_type
    #   @return [String] Summary Type. Legal values: AramUnranked5x5, CoopVsAI, OdinUnranked, RankedPremade3x3, RankedPremade5x5, RankedSolo5x5, RankedTeam3x3, RankedTeam5x5, Unranked, Unranked3x3
    attr_reader :player_stat_summary_type

    # @!attribute [r] wins
    #   @return [Fixnum] Number of wins for this queue type
    attr_reader :wins

    private

    attr_writer :id, :losses, :modify_date_str, :player_stat_summary_type,
                :wins, :aggregated_stats

    def modify_date= value
      @modify_date = value.is_a?(Numeric) && Time.at(value / 1000) || value
    end
  end
end
