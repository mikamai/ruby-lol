require 'lol/model'

module Lol
  class AggregatedStatistic < Lol::Model
    # @!attribute [r] raw
    #   @return [Hash] raw version of options Hash used to initialize AggregatedStatistic
    attr_reader :raw

    # @!attribute [r] id
    #   @return [Fixnum] Statistic Type Id
    attr_reader :id

    # @!attribute [r] name
    #   @return [String] Statistic Type name
    attr_reader :name

    # @!attribute [r] count
    #   @return [Fixnum] Statistic value
    attr_reader :count

    private

    attr_writer :id, :name, :count
  end
end