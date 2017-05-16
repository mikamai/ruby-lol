require 'lol/model'

module Lol
  class TeamMember < Lol::Model
    # @!attribute [r] invite_date
    # @return [Time] Invite date
    attr_reader :invite_date

    # @!attribute [r] join_date
    # @return [Time] Join date
    attr_reader :join_date

    # @!attribute [r] player_id
    # @return [Integer] Player Id
    attr_reader :player_id

    # @!attribute [r] status
    # @return [String] Status
    attr_reader :status

    private

    attr_writer :player_id, :status

    def invite_date= value
      @invite_date = value.is_a?(Numeric) && Time.at(value / 1000) || value
    end

    def join_date= value
      @join_date = value.is_a?(Numeric) && Time.at(value / 1000) || value
    end
  end
end
