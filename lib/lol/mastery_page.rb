module Lol
  class MasteryPage < Model

    # @!attribute [r] id
    # @return [Fixnum] mastery page id
    attr_reader :id

    # @!attribute [r] masteries
    # @return [Array] array of Lol::Mastery
    attr_reader :masteries

    # @!attribute [r] name
    # @return [String] name of mastery page
    attr_reader :name

    # @!attribute [r] current
    # @return [Boolean] is it the current mastery page?
    attr_reader :current

    private

    attr_writer :id, :name, :current

    def masteries= new_masteries
      @masteries = new_masteries.map {|t| Mastery.new t}
    end
  end
end
