module Lol
  class Game
    # Initializes a Lol::Game
    # @param options [Hash]
    # @return [Lol::Game]
    def initialize options = {}
      @raw = options
    end

    def raw
      @raw
    end
  end
end