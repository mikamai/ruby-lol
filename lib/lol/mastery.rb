module Lol
  class Mastery < Model

    # @!attribute [r] id
    # @return [Fixnum] id of talent
    attr_reader :id

    # @!attribute [r] rank
    # @return [Fixnum] rank of talent
    attr_reader :rank

    private

    attr_writer :id, :rank
  end
end
