require "spec_helper"
require "lol"

describe Lol::SpectatorRequest do
  subject { described_class.new "api_key", "euw" }
  let(:encrypted_id) { 'qHn0uNkpA1T-NqQ0zHTEqNh1BhH5SAsGWwkZsacbeKBqSdkUEaYOcYNjDomm60vMrLWHu4ulYg1C5Q' }

  describe "#current_game" do
    it "returns a DynamicModel" do
      stub_request subject, "current-game", "active-games/by-summoner/#{encrypted_id}"
      expect(subject.current_game encrypted_summoner_id: encrypted_id).to be_a Lol::DynamicModel
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
