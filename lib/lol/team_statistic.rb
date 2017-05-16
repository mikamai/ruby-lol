require 'lol/model'

module Lol
  class TeamStatistic < Lol::Model
    # @!attribute [r] full_id
    # @return [String] Full Team ID
    attr_reader :full_id

    # @!attribute [r] average_games_played
    # @return [Integer] Average games played
    attr_reader :average_games_played

    # @!attribute [r] average_games_played
    # @return [Integer] Average games played
    attr_reader :average_games_played

    # @!attribute [r] losses
    # @return [Integer] Number of losses
    attr_reader :losses

    # @!attribute [r] max_rating
    # @return [Integer] Max Ratingx
    attr_reader :max_rating

    # @!attribute [r] rating
    # @return [Integer] Rating
    attr_reader :rating

    # @!attribute [r] seed_rating
    # @return [Integer] Seed Rating
    attr_reader :seed_rating

    # @!attribute [r] team_id
    # @return [Integer] Team Id
    attr_reader :team_id

    # @!attribute [r] team_stat_type
    # @return [String] Team Statistic Type name
    attr_reader :team_stat_type

    # @!attribute [r] wins
    # @return [Integer] Number of wins
    attr_reader :wins

    private

    attr_writer :average_games_played, :losses, :max_rating, :rating, :seed_rating, :team_stat_type, :wins, :full_id

    def team_id= value
      @team_id = value.is_a?(Hash) && value['fullId'] || value
    end
  end
end
