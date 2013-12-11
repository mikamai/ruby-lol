module Lol
  class Champion

    # Initializes a Lol::Champion
    # @param options [Hash]
    # @return [Lol::Champion]
    def initialize options = {}
      @raw = options
    end

    def raw
      @raw
    end
  end
end
