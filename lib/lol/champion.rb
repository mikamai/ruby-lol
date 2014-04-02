module Lol
  class Champion < Lol::Model
    # @!attribute [r] id
    # @return [Fixnum] id of Champion
    attr_reader :id

    # @!attribute [r] active
    # @return [true] if the Champion is active
    # @return [false] if the Champion is disabled
    attr_reader :active

    # @!attribute [r] bot_enabled
    # @return [true] if the Champion is enabled in custom bot games
    # @return [false] if the Champion is disabled in custom bot games
    attr_reader :bot_enabled

    # @!attribute [r] free_to_play
    # @return [true] if the Champion is currently free to play
    # @return [false] if the Champion isn't currently free to play
    attr_reader :free_to_play

    # @!attribute [r] bot_mm_enabled
    # @return [true] if the Champion is enabled in match made bot games
    # @return [false] if the Champion is disabled in match made bot games
    attr_reader :bot_mm_enabled

    # @!attribute [r] ranked_play_enabled
    # @return [true] if the Champion is enabled in ranked play
    # @return [false] if the Champion is disabled in ranked play
    attr_reader :ranked_play_enabled

    private

    attr_writer :id, :active, :bot_enabled, :free_to_play, :bot_mm_enabled,
                :ranked_play_enabled
  end
end
