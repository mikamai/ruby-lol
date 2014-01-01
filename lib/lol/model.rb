require 'active_support/core_ext/string/inflections'

module Lol
  class Model
    # @!attribute [r] raw
    # @return [Hash] raw version of options Hash used to initialize Model
    attr_reader :raw

    # Initializes a Lol::Model
    # @param options [Hash]
    # @return [Lol::Model]
    def initialize options = {}
      @raw = options
      options.each do |attribute_name, value|
        send "#{attribute_name.to_s.underscore}=", value
      end
    end
  end
end
