module Lol
  class ChampionRequest
    # @!attribute [r] api_key
    #   @return [String] api_key
    attr_accessor :region

    # @paramt
    def initialize api_key
      @api_key = api_key
    end


    private

    # Sets api_key to new_key
    # @param new_key [String] a Riot Games API key
    # @return [String] new_key
    def api_key= new_key
      @api_key = new_key
    end
  end
end
