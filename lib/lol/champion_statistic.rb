require 'lol/model'

module Lol
  class ChampionStatistic < Lol::Model
    # @!attribute [r] raw
    #   @return [Hash] raw version of options Hash used to initialize ChampionStatistic
    attr_reader :raw

    # @!attribute [r] c
    #   @return [Fixnum] Count of samples (games) that make up the aggregated value, where relevant.
    attr_reader :c

    # @!attribute [r] id
    #   @return [Fixnum] Aggregated stat type Id
    attr_reader :id

    # @!attribute [r] name
    #   @return [String] Aggregated stat type Name
    attr_reader :name

    # @!attribute [r] value
    #   @return [Fixnum] Aggregated stat type Value
    attr_reader :value

    private

    attr_writer :id, :name, :c, :value
  end
end