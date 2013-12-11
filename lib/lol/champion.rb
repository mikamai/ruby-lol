module Lol
  class Champion


    # @!attribute [r] raw
    #   @return [String] raw version of options Hash used to initialize Champion
    attr_reader :raw

    # @!attribute [r] id
    #   @return [Fixnum] id of Champion
    attr_reader :id

    # @!attribute [r] name
    #   @return [String] name of Champion
    attr_reader :name

    # @!attribute [r] active
    #   @return [true] if the Champion is active
    #   @return [false] if the Champion is disabled
    attr_reader :active

    # @!attribute [r] attack_rank
    #   @return [Fixnum] attack rank of Champion
    attr_reader :attack_rank

    # @!attribute [r] defense_rank
    #   @return [Fixnum] defense rank of Champion
    attr_reader :defense_rank

    # @!attribute [r] magic_rank
    #   @return [Fixnum] magic rank of Champion
    attr_reader :magic_rank

    # @!attribute [r] difficulty_rank
    #   @return [Fixnum] difficulty rank of Champion
    attr_reader :difficulty_rank

    # @!attribute [r] bot_enabled
    #   @return [true] if the Champion is enabled in custom bot games
    #   @return [false] if the Champion is disabled in custom bot games
    attr_reader :bot_enabled

    # @!attribute [r] free_to_play
    #   @return [true] if the Champion is currently free to play
    #   @return [false] if the Champion isn't currently free to play
    attr_reader :free_to_play

    # @!attribute [r] bot_mm_enabled
    #   @return [true] if the Champion is enabled in match made bot games
    #   @return [false] if the Champion is disabled in match made bot games
    attr_reader :bot_mm_enabled

    # @!attribute [r] ranked_play_enabled
    #   @return [true] if the Champion is enabled in ranked play
    #   @return [false] if the Champion is disabled in ranked play
    attr_reader :ranked_play_enabled

    # Initializes a Lol::Champion
    # @param options [Hash]
    # @return [Lol::Champion]
    def initialize options = {}
      @raw = options
      @id = options.delete "id"
      @name = options.delete "name"
      @active = options.delete "active"
      @attack_rank = options.delete "attackRank"
      @defense_rank = options.delete "defenseRank"
      @magic_rank = options.delete "magicRank"
      @difficulty_rank = options.delete "difficultyRank"
      @bot_enabled = options.delete "botEnabled"
      @free_to_play = options.delete "freeToPlay"
      @bot_mm_enabled = options.delete "botMmEnabled"
      @ranked_play_enabled = options.delete "rankedPlayEnabled"
    end
  end
end
