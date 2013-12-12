module Lol
  class Statistic
    # @!attribute [r] raw
    #   @return [Hash] raw version of options Hash used to initialize Statistic
    attr_reader :raw

    # @!attribute [r] id
    #   @return [Fixnum] Raw Statistic Id
    attr_reader :id

    # @!attribute [r] name
    #   @return [String] Raw Statistic name
    attr_reader :name

    # @!attribute [r] value
    #   @return [Fixnum] Raw Statistic value
    attr_reader :value

    # Initializes a Lol::Statistic
    # @param options [Hash]
    # @return [Lol::Statistic]
    def initialize options = {}
      @raw = options
      options.each do |attribute_name, value|
        send "#{attribute_name.to_s.underscore}=", value
      end
    end

    private

    attr_writer :id, :name, :value
  end
end