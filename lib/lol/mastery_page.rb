module Lol
  class MasteryPage < Model

    # @!attribute [r] id
    # @return [Fixnum] id of summoner
    attr_reader :summoner_id

    # @!attribute [r] talents
    # @return [Array] array of Lol::Talent
    attr_reader :talents

    # @!attribute [r] name
    # @return [String] name of mastery page
    attr_reader :name

    # @!attribute [r] current
    # @return [Boolean] is it the current mastery page?
    attr_reader :current

    private

    attr_writer :summoner_id, :name, :current

    def talents= new_talents
      @talents = new_talents.map {|t| Talent.new t}
    end
  end
end
