module Lol
  # This object exposes LeagueListDto properties, returned by league-related requests,
  # as accessors.
  #
  # See: https://developer.riotgames.com/api-methods/#league-v3
  class LeagueList < DynamicModel
    # @!attribute tier
    #   @return [String] Tier name

    # @!attribute queue
    #   @return [String] Queue identifier

    # @!attribute name
    #   @return [String] League name

    # @!attribute entries
    #   @return [Array<LeagueEntry>] summoner / teams in queue

    protected

    # @!visibility private
    def class_for_property property
      case property
      when :entries then LeagueEntry
      else super
      end
    end
  end
end
