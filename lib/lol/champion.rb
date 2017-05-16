module Lol
  # This object exposes ChampionDto properties, returned by champion-related requests,
  # as accessors.
  #
  # See: https://developer.riotgames.com/api-methods/#champion-v3
  class Champion < DynamicModel
    # @!attribute ranked_play_enabled
    #   @return [true|false] Ranked play enabled flag

    # @!attribute bot_enabled
    #   @return [true|false] Bot enabled flag (for custom games)

    # @!attribute bot_mm_enabled
    #   @return [true|false] Bot Match Made enabled flag (for Co-op vs. AI games)

    # @!attribute active
    #   @return [true|false] Indicated if the champion is active

    # @!attribute free_to_play
    #   @return [true|false] Indicated if the champion is free to play. Free to play champions are rotated periodically

    # @!attribute id
    #   @return [Integer] Champion ID. For static information correlating to champion IDs, please refer to the LoL Static Data API
  end
end
