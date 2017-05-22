require "spec_helper"
require "lol"
include Lol

describe ChampionMasteryRequest do
  subject { ChampionMasteryRequest.new("api_key", "euw") }

  it "inherits from Request" do
    expect(ChampionMasteryRequest.ancestors[1]).to eq V3Request
  end

  describe "#total_score" do
    it "returns the total score" do
      stub_request_raw subject, 60, 'scores/by-summoner/1'
      expect(subject.total_score summoner_id: 1).to eq 60
    end
  end

  describe "#find" do
    it "returns a ChampionMastery" do
      stub_request(subject, 'champion-mastery', 'champion-masteries/by-summoner/1/by-champion/40')
      expect(subject.find 40, summoner_id: 1).to be_a DynamicModel
    end

    it "fetches ChampionMastery from the API" do
      stub_request(subject, 'champion-mastery', 'champion-masteries/by-summoner/1/by-champion/40')
      result = subject.find 40, summoner_id: 1
      expect(result.highest_grade).to eq('S+')
      expect(result.champion_points).to eq(34356)
      expect(result.player_id).to eq(1)
      expect(result.champion_points_until_next_level).to eq(0)
      expect(result.chest_granted).to be(true)
      expect(result.champion_level).to eq(5)
      expect(result.tokens_earned).to eq(2)
      expect(result.champion_id).to eq(40)
      expect(result.champion_points_since_last_level).to eq(12756)
    end
  end

  describe "#all" do
    before { stub_request(subject, 'champion-masteries', 'champion-masteries/by-summoner/1') }
    let(:result) { subject.all summoner_id: 1 }

    it "returns an Array of ChampionMastery" do
      expect(result).to be_a Array
      expect(result.map(&:class).uniq).to eq [DynamicModel]
    end

    it "fetches ChampionMastery properties from the API" do
      fixture = load_fixture('champion-masteries', described_class.api_version)
      expect(result.count).to eq fixture.count
    end
  end
end
