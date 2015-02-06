module Lol
  class Shard < Model
    attr_reader :hostname
    attr_reader :locale
    attr_reader :name
    attr_reader :region_tag
    attr_reader :slug
    attr_reader :locales

    private

    attr_writer :hostname, :name, :region_tag, :slug, :locales
  end
end
