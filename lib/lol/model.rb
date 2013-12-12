require 'active_support/core_ext/string/inflections'

module Lol
  class Model
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