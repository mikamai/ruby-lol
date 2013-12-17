module Lol
  class ChampionRequest < Request

    # Retrieve all champions, v1.1
    # @return [Array] an array of champions
    def get
      perform_request(api_url("v1.1", "champion"))["champions"].map {|c| Champion.new(c)}
    end

  end
end
