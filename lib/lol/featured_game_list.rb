module Lol
  # List of featured games
  #
  # Each contained featured game is represented through {DynamicModel}
  class FeaturedGameList < Array
    # The suggested interval to wait before requesting FeaturedGames again
    # @return [Integer]
    attr_reader :client_refresh_interval

    def initialize data
      @client_refresh_interval = data['clientRefreshInterval']
      super data['gameList'].map { |g| DynamicModel.new g }
    end
  end
end
