require 'active_support/deprecation'

module Lol
  # Bindings for the Champion API.
  #
  # See: https://developer.riotgames.com/api-methods/#champion-v3
  class ChampionRequest < V3Request
    # Retrieve all champions
    #
    # See: https://developer.riotgames.com/api-methods/#champion-v3/GET_getChampions
    # @param free_to_play [Boolean] filter param to retrieve only free to play champions
    # @return [Array<Lol::Champion>] an array of champions
    def all free_to_play: false
      result = perform_request api_url("champions", "freeToPlay" => free_to_play)
      result["champions"].map { |c| Champion.new c }
    end

    # Retrieve champion by ID
    #
    # See: https://developer.riotgames.com/api-methods/#champion-v3/GET_getChampionsById
    # @param id [Fixnum] id of the champion to get
    # @return [Champion] the found champion
    def find id
      result = perform_request api_url "champions/#{id}"
      Champion.new result
    end
  
    # Retrieve all champions
    # @deprecated Please use {ChampionRequest#find} and {ChampionRequest#all} instead.
    # @param [Hash] options the options to pass to the call
    # @option options [Fixnum] :id the champion to get. If nil gets all champions
    # @option options [Boolean] :free_to_play filters for free to play champions
    # @return [Array] an array of champions
    def get options = {}
      champion_id = options.delete :id
      if champion_id
        warn_for_deprecation "ChampionRequest#get(champion_id: #{champion_id}, ...) has been deprecated. Use ChampionRequest#find(#{champion_id}) instead"
        find champion_id if champion_id
      else
        free_to_play = !!options[:free_to_play]
        warn_for_deprecation "ChampionRequest#get(free_to_play: #{free_to_play}) has been deprecated. Use ChampionRequest#all(free_to_play: #{free_to_play} instead"
        all free_to_play: free_to_play
      end
    end

    private

    def warn_for_deprecation message
      ActiveSupport::Deprecation.warn message
    end
  end
end
