require 'lol/model'

module Lol
  class RankedStatisticsSummary < Lol::Model
    # @!attribute [r] champions
    #   @return [Array] List of player stats summarized by champion
    attr_reader :champions

    # @!attribute [r] modify_date
    #   @return [Time] Time stats were last updated
    attr_reader :modify_date

    # @!attribute [r] modify_date_str
    #   @return [String] Human readable string representing date stats were last updated
    attr_reader :modify_date_str

    # @!attribute [r] summoner_id
    #   @return [Fixnum] Summoner Id
    attr_reader :summoner_id

    private

    attr_writer :modify_date_str, :summoner_id

    def modify_date= value
      @modify_date = value.is_a?(Numeric) && Time.at(value / 1000) || value
    end

    def champions= collection
      @champions = collection.map do |c|
        c.respond_to?(:[]) && ChampionStatisticsSummary.new(c) || c
      end
    end
  end
end
