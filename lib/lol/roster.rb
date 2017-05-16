require 'lol/model'

module Lol
  class Roster < Lol::Model
    # @!attribute [r] owner_id
    # @return [Integer] Team Owner Id
    attr_reader :owner_id

    # @!attribute [r] member_list
    # @return [Array] List of members
    attr_reader :member_list

    private

    attr_writer :owner_id

    def member_list= collection
      @member_list = collection.map do |c|
        c.respond_to?(:[]) && TeamMember.new(c) || c
      end
    end
  end
end
