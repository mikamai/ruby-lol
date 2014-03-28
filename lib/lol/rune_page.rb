module Lol
  class RunePage < Model
    # @!attribute [r] id
    # @return [Fixnum] id of Runepage
    attr_reader :id

    # @!attribute [r] name
    # @return [String] name of Runepage
    attr_reader :name

    # @!attribute [r] current
    # @return [Boolean] is the Runepage currently active?
    attr_reader :current


    # @!attribute [r] current
    # @return [Array] array of Lol::RuneSlot
    attr_reader :slots

    private

    attr_writer :id, :name, :current

    def slots= *runeslots
      @slots = runeslots.flatten.map {|slot| RuneSlot.new slot}
    end
  end
end
