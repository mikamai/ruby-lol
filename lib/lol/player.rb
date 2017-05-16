require 'lol/model'

module Lol
  class Player < Lol::Model
    # @!attribute [r] champion_id
    # @return [Integer] Champion Id associated with player
    attr_reader :champion_id

    # @!attribute [r] summoner_id
    # @return [Integer] Summoner Id associated with player
    attr_reader :summoner_id

    # @!attribute [r] team_id
    # @return [Integer] Team Id associated with player
    attr_reader :team_id

    private

    attr_writer :champion_id, :summoner_id, :team_id
  end
end
