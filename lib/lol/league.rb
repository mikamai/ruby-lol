module Lol
  # Holds the representation of a League
  class League < Model
    # @!attribute [r] name
    # @return [String] name of league
    attr_reader :name

    # @!attribute [r] tier
    # @return [String] tier of league
    attr_reader :tier

    # @!attribute [r] queue
    # @return [String] type of queue
    attr_reader :queue

    # @!attribute [r] entries
    # @return [String] summoners / teams in queue
    attr_reader :entries

    private

    attr_writer :timestamp, :name, :tier, :queue

    def entries= list
      @entries = []
      list.each {|entry| @entries << LeagueEntry.new(entry)}
    end
  end
end
