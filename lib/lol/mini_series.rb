module Lol
  # Holds the representation of a MiniSeries
  class MiniSeries < Model
    # @!attribute [r] target
    # @return [String] number of games required to advance
    attr_reader :target

    # @!attribute [r] wins
    # @return [Fixnum] wins in the miniseries
    attr_reader :wins

    # @!attribute [r] losses
    # @return [Fixnum] losses in the miniseries
    attr_reader :losses

    # @!attribute [r] time_left_to_play_millis
    # @return [Fixnum] time left to play the miniseries, expressed in milliseconds
    attr_reader :time_left_to_play_millis

    # @!attribute [r] progress
    # @return [String] string representation of the miniseries progress.
    #           i.e. "WLN" (Win / Loss / Not played)
    attr_reader :progress

    private

    attr_writer :target, :wins, :losses, :time_left_to_play_millis, :progress
  end
end
