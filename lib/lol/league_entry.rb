module Lol
  # Holds the representation of a League
  class LeagueEntry < Model
    # @!attribute [r] timestamp
    #   @return [String] timestamp of league snapshot
    attr_reader :timestamp

    # @!attribute [r] name
    #   @return [String] name of league
    attr_reader :name

    # @!attribute [r] tier
    #   @return [String] tier of league
    attr_reader :tier

    # @!attribute [r] queue
    #   @return [String] type of queue
    attr_reader :queue

    # @!attribute [r] entries
    #   @return [String] summoners / teams in queue
    attr_reader :entries

    private

    attr_writer :timestamp, :name, :tier, :queue

    def entries= list
      "foo"
    end
  end
end
