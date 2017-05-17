require "spec_helper"
require "lol"

describe Lol::SpectatorRequest do
  subject { described_class.new "api_key", "euw" }

  describe "#current_game" do
    it "returns a DynamicModel" do
      stub_request subject, "current-game", "active-games/by-summoner/23"
      expect(subject.current_game summoner_id: 23).to be_a Lol::DynamicModel
    end
  end

  describe "#featured_games" do
    it "returns a FeaturedGameList" do
      stub_request subject, "featured-games", "featured-games"
      result = subject.featured_games
      expect(result).to be_a Lol::FeaturedGameList
      expect(result.client_refresh_interval).not_to be_nil
      expect(result.size).not_to be_zero
    end
  end
end
