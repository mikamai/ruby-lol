module Lol
  class Talent < Model

    # @!attribute [r] id
    #   @return [Fixnum] id of talent
    attr_reader :id

    # @!attribute [r] name
    #   @return [String] name of talent
    attr_reader :name

    # @!attribute [r] rank
    #   @return [Fixnum] rank of talent
    attr_reader :rank

    private

    attr_writer :id, :name, :rank
  end
end
