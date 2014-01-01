require 'lol/model'

module Lol
  class ChampionStatisticsSummary < Lol::Model
    # @!attribute [r] id
    # @return [Fixnum] Champion Id
    attr_reader :id

    # @!attribute [r] name
    # @return [String] Champion Name
    attr_reader :name

    # @!attribute [r] stats
    # @return [Array] List of stats associated with this champion
    attr_reader :stats

    private

    attr_writer :id, :name

    def stats= value
      @stats = value.is_a?(Hash) && OpenStruct.new(underscore_hash_keys value) || value
    end

    def underscore_hash_keys hash
      hash.inject({}) { |memo, (key, value)| memo.update key.to_s.underscore => value }
    end
  end
end
