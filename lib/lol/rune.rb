module Lol
  class Rune < Model
    # @!attribute [r] id
    # @return [Fixnum] Rune id
    attr_reader :id

    # @!attribute [r] name
    # @return [String] Rune name
    attr_reader :name

    # @!attribute [r] description
    # @return [String] Rune description
    attr_reader :description

    # @!attribute [r] tier
    # @return [Fixnum] Rune tier
    attr_reader :tier

    private

    attr_writer :id, :name, :description, :tier
  end
end
