module Lol
  class MasteryPage < Model
    attr_reader :summoner_id
    attr_reader :talents

    private

    attr_writer :summoner_id

    def talents= new_talents
      @talents = new_talents.map {|t| Talent.new t}
    end
  end
end
