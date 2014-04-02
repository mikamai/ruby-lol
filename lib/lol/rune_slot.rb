module Lol
  class RuneSlot < Model
    # @!attribute [r] id
    # @return [Fixnum] id of RuneSlot
    def id
      @rune_slot_id
    end

    # @!attribute [r] rune_id
    # @return [Fixnum] id of Rune
    def rune_id
      @rune_id
    end

    private

    def id= new_id
      @rune_slot_id = new_id
    end

    def rune_id= new_id
      @rune_id = new_id
    end

    def rune_slot_id= new_id
      @rune_slot_id = new_id
    end
  end
end
