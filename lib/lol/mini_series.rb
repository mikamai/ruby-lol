module Lol
  # This object exposes MiniSeriesDTO properties, returned by league-related requests,
  # as accessors.
  #
  # See: https://developer.riotgames.com/api-methods/#league-v3
  class MiniSeries < DynamicModel
    # @!attribute wins
    #   @return [Fixnum] Number of wins

    # @!attribute losses
    #   @return [Fixnum] Number of losses

    # @!attribute target
    #   @return [Fixnum] Number of games required to advance

    # @!attribute progress
    #   @return [String] string representation of the miniseries progress.
    #           i.e. "WLN" (Win / Loss / Not played)
  end
end
