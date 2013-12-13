require 'lol/model'

module Lol
  class ChampionStatisticsSummary < Lol::Model
    # @!attribute [r] raw
    #   @return [Hash] raw version of options Hash used to initialize ChampionStatisticsSummary
    attr_reader :raw

    # @!attribute [r] id
    #   @return [Fixnum] Champion Id
    attr_reader :id

    # @!attribute [r] name
    #   @return [String] Champion Name
    attr_reader :name

    # @!attribute [r] stats
    #   @return [Array] List of stats associated with this champion
    attr_reader :stats

    private

    attr_writer :id, :name

    def stats= collection
      @stats = collection.map do |c|
        c.respond_to?(:[]) && ChampionStatistic.new(c) || c
      end
    end
  end
end