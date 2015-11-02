require 'lol/model'

module Lol
  class TournamentCode < Lol::Model
    attr_reader :id

    attr_reader :provider_id

    # @!attribute [r] tournament_id
    # @return [Fixnum] Tournament ID
    attr_reader :tournament_id

    # @!attribute [r] code
    # @return [String] Code
    attr_reader :code

    # @!attribute [r] region
    # @return [String] Region
    attr_reader :region

    # @!attribute [r] map
    # @return [String] Map
    attr_reader :map

    # @!attribute [r] team_size
    # @return [Fixnum] Team Size
    attr_reader :team_size

    # @!attribute [r] spectators
    # @return [String] Spectators Type
    attr_reader :spectators

    # @!attribute [r] pick_type
    # @return [String] Pick Type
    attr_reader :pick_type

    # @!attribute [r] lobby_name
    # @return [String] Lobby Name
    attr_reader :lobby_name

    attr_reader :password

    private

    attr_writer :id, :provider_id, :tournament_id, :code, :region, :map, :team_size,
                :spectators, :pick_type, :lobby_name, :password
  end
end
