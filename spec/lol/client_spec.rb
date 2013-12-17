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
    it 'defaults to v1.1' do
      expect(subject).to receive(:stats11).with 'foo'
      subject.stats 'foo'
    end
  end

  describe '#stats11' do
    let(:client) { Client.new 'foo' }
    let(:fixture) { load_fixture 'stats', 'v1.1', 'get' }

    subject do
      expect(Client).to receive(:get).with(client.api_url('v1.1', "stats/by-summoner/1/summary")).and_return fixture
      client.stats11 1
    end

    it 'requires a summoner' do
      expect { client.stats }.to raise_error ArgumentError
    end

    it 'returns an array' do
      expect(subject).to be_a Array
    end

    it 'returns an array of PlayerStatistic' do
      expect(subject.map(&:class).uniq).to eq [PlayerStatistic]
    end

    it 'fetches PlayerStatistics from the API' do
      expect(subject.size).to eq load_fixture('stats', 'v1.1', 'get')['playerStatSummaries'].size
    end

    it 'optionally accepts a season' do
      expect(Client).to receive(:get).with(client.api_url('v1.1', 'stats/by-summoner/1/summary', season: '1')).and_return fixture
      client.stats11 '1', season: '1'
    end

    it 'raises an error when unexpected parameter is received' do
      expect { client.stats11 '1', asd: 'foo' }.to raise_error ArgumentError
    end
  end

  describe '#ranked_stats' do
    it 'defaults to v1.1' do
      expect(subject).to receive(:ranked_stats11).with 'foo'
      subject.ranked_stats 'foo'
    end
  end

  describe '#ranked_stats11' do
    let(:client) { Client.new 'foo' }
    let(:fixture) { load_fixture 'ranked_stats', 'v1.1', 'get' }

    subject do
      expect(Client).to receive(:get).with(client.api_url('v1.1', "stats/by-summoner/1/ranked")).and_return fixture
      client.ranked_stats11 1
    end

    it 'requires a summoner' do
      expect { client.ranked_stats }.to raise_error ArgumentError
    end

    it 'returns a RankedStatisticsSummary' do
      expect(subject).to be_a RankedStatisticsSummary
    end

    it 'fetches RankedStatisticsSummary from the API' do
      expect(subject.champions.size).to eq load_fixture('ranked_stats', 'v1.1', 'get')['champions'].size
    end

    it 'optionally accepts a season' do
      expect(Client).to receive(:get).with(client.api_url('v1.1', 'stats/by-summoner/1/ranked', season: '1')).and_return fixture
      client.ranked_stats11 '1', season: '1'
    end

    it 'raises an error when unexpected parameter is received' do
      expect { client.ranked_stats11 '1', asd: 'foo' }.to raise_error ArgumentError
    end
  end

  describe '#team' do
    it 'defaults to v2.1' do
      expect(subject).to receive(:team21).with 'foo'
      subject.team 'foo'
    end
  end

  describe '#team21' do
    let(:client) { Client.new 'foo' }
    let(:fixture) { load_fixture 'team', 'v2.1', 'get' }

    subject do
      expect(Client).to receive(:get).with(client.api_url('v2.1', "team/by-summoner/1")).and_return fixture
      client.team21 1
    end

    it 'requires a summoner' do
      expect { client.team21 }.to raise_error ArgumentError
    end

    it 'returns an array' do
      expect(subject).to be_a Array
    end

    it 'returns an array of Team' do
      expect(subject.map(&:class).uniq).to eq [Team]
    end

    it 'fetches Team from the API' do
      expect(subject.size).to eq fixture.size
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

  describe "#api_key" do
    it "returns an api key" do
      expect(subject.api_key).to eq("foo")
    end

    it "is read_only" do
      expect { subject.api_key = "bar" }.to raise_error(NoMethodError)
    end
  end

  describe "league" do
    it "calls latest version of league" do
      expect(subject).to receive(:league21)
      subject.league("foo")
    end
  end

  describe "league21" do
    let(:client) { Client.new "foo" }

    subject do
      expect(client).to receive(:get).with(client.api_url("v2.1", "league/by-summoner/foo")).and_return(load_fixture("league", "v2.1", "get"))

      client.league21("foo")
    end

    it "returns an array of Leagues" do
      expect(subject.map(&:class).uniq).to eq([League])
    end
  end
end
