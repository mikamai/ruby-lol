module Lol
  class RuneSlot < Model
    # @!attribute [r] id
    # @return [Fixnum] id of RuneSlot
    def id
      @rune_slot_id
    end

    # @!attribute [r] rune
    # @return [Rune] rune placed in the slot
    attr_reader :rune

    private

    def rune= rune_data
      @rune = Rune.new rune_data
    end

    def id= new_id
      @rune_slot_id = new_id
    end

    def rune_slot_id= new_id
      @rune_slot_id = new_id
    end
  end
end
