require "spec_helper"
require "lol"

include Lol

describe Client do
  subject { Client.new "foo" }

  describe "#new" do
    it "requires an API key argument" do
      expect { Client.new }.to raise_error(ArgumentError)
    end

    it "accepts a region argument" do
      expect { Client.new("foo", :region => "na") }.not_to raise_error
    end

    it "defaults on EUW as a region" do
      expect(subject.region).to eq("euw")
    end
  end


  describe "#champion" do
    it "returns an instance of ChampionRequest" do
      expect(subject.champion).to be_a(ChampionRequest)
    end

    it "initializes the ChampionRequest with the current API key and region" do
      expect(ChampionRequest).to receive(:new).with(subject.api_key, subject.region)

      subject.champion
    end
  end

  describe '#game' do
    it "returns an instance of GameRequest" do
      expect(subject.game).to be_a(GameRequest)
    end

    it "initializes the GameRequest with the current API key and region" do
      expect(GameRequest).to receive(:new).with(subject.api_key, subject.region)

      subject.game
    end
  end

  describe '#stats' do
    it "returns an instance of StatsRequest" do
      expect(subject.stats).to be_a(StatsRequest)
    end

    it "initializes the StatsRequest with the current API key and region" do
      expect(StatsRequest).to receive(:new).with(subject.api_key, subject.region)

      subject.stats
    end
  end

  describe '#team' do
    it "returns an instance of TeamRequest" do
      expect(subject.team).to be_a(TeamRequest)
    end

    it "initializes the TeamRequest with the current API key and region" do
      expect(TeamRequest).to receive(:new).with(subject.api_key, subject.region)

      subject.team
    end
  end

  describe "#league" do
    it "returns an instance of LeagueRequest" do
      expect(subject.league).to be_a(LeagueRequest)
    end

    it "initializes the LeagueRequest with the current API key and region" do
      expect(LeagueRequest).to receive(:new).with(subject.api_key, subject.region)

      subject.league
    end
  end

  describe "#api_key" do
    it "returns an api key" do
      expect(subject.api_key).to eq("foo")
    end

    it "is read_only" do
      expect { subject.api_key = "bar" }.to raise_error(NoMethodError)
    end
  end

  describe "#region" do
    it "returns current region" do
      expect(subject.region).to eq("euw")
    end

    it "can be set to a new region" do
      subject.region = "NA"
      expect(subject.region).to eq("NA")
    end
  end

end
