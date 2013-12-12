module Lol
  class Player
    # @!attribute [r] raw
    #   @return [Hash] raw version of options Hash used to initialize Player
    attr_reader :raw

    # @!attribute [r] champion_id
    #   @return [Fixnum] Champion Id associated with player
    attr_reader :champion_id

    # @!attribute [r] summoner_id
    #   @return [Fixnum] Summoner Id associated with player
    attr_reader :summoner_id

    # @!attribute [r] team_id
    #   @return [Fixnum] Team Id associated with player
    attr_reader :team_id

    # Initializes a Lol::Player
    # @param options [Hash]
    # @return [Lol::Player]
    def initialize options = {}
      @raw = options
      options.each do |attribute_name, value|
        send "#{attribute_name.to_s.underscore}=", value
      end
    end

    private

    attr_writer :champion_id, :summoner_id, :team_id
  end
end