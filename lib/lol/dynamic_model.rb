require 'ostruct'
require 'active_support/core_ext/string/inflections'

module Lol
  # DynamicModel extends OpenStruct adding the following features:
  # - nested generation ({a: {}}) results in DynamicModel(a: DynamicModel)
  # - parsing of date/time when property name ends with _at or _date and the value is a number
  class DynamicModel < OpenStruct
    def initialize(hash={})
      raise ArgumentError, 'An hash is required as parameter' unless hash.is_a? Hash
      @table = {}
      @hash_table = {}

      hash.each do |k,v|
        key = k.to_s.underscore
        set_property key, v
        new_ostruct_member(key)
      end
    end

    def to_h
      @hash_table
    end

    def as_json opts={}
      @table.as_json
    end

    private

    def date_key? key
      key.match(/^(.+_)?(at|date)$/)
    end

    def set_property key, v
      if date_key?(key) && v.is_a?(Fixnum)
        @table[key.to_sym] = @hash_table[key.to_sym] = value_to_date v
      else
        @table[key.to_sym] = convert_object v
        @hash_table[key.to_sym] = v
      end
    end

    def value_to_date v
      Time.at(v / 1000)
    end

    def convert_object obj
      if obj.is_a? Hash
        self.class.new obj
      elsif obj.respond_to?(:map)
        obj.map { |o| convert_object o }
      else
        obj
      end
    end
  end
end
