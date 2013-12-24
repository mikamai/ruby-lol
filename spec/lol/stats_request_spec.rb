require "spec_helper"
require "lol"

include Lol

describe StatsRequest do
  let(:request) { StatsRequest.new "api_key", "euw" }

  it "inherits from Request" do
    expect(GameRequest.ancestors[1]).to eq(Request)
  end

  describe "#summary" do
    let(:fixture) { load_fixture 'stats', 'v1.2', 'get' }

    subject do
      expect(request.class).to receive(:get).with(request.api_url('v1.2', "stats/by-summoner/1/summary")).and_return fixture

      request.summary 1
    end

    it 'requires a summoner' do
      expect { request.summary }.to raise_error ArgumentError
    end

    it 'returns an array' do
      expect(subject).to be_a Array
    end

    it 'returns an array of PlayerStatistic' do
      expect(subject.map(&:class).uniq).to eq [PlayerStatistic]
    end

    it 'fetches PlayerStatistics from the API' do
      expect(subject.size).to eq load_fixture('stats', 'v1.2', 'get')['playerStatSummaries'].size
    end

    it 'optionally accepts a season' do
      expect(request.class).to receive(:get).with(request.api_url('v1.2', 'stats/by-summoner/1/summary', season: '1')).and_return fixture
      request.summary '1', season: '1'
    end

    it 'raises an error when unexpected parameter is received' do
      expect { request.summary '1', asd: 'foo' }.to raise_error ArgumentError
    end
  end

  describe "#ranked" do
    let(:fixture) { load_fixture 'ranked_stats', 'v1.1', 'get' }

    subject do
      expect(request.class).to receive(:get).with(request.api_url('v1.1', "stats/by-summoner/1/ranked")).and_return fixture
      request.ranked 1
    end

    it 'requires a summoner' do
      expect { request.ranked }.to raise_error ArgumentError
    end

    it 'returns a RankedStatisticsSummary' do
      expect(subject).to be_a RankedStatisticsSummary
    end

    it 'fetches RankedStatisticsSummary from the API' do
      expect(subject.champions.size).to eq load_fixture('ranked_stats', 'v1.1', 'get')['champions'].size
    end

    it 'optionally accepts a season' do
      expect(request.class).to receive(:get).with(request.api_url('v1.1', 'stats/by-summoner/1/ranked', season: '1')).and_return fixture

      request.ranked '1', season: '1'
    end

    it 'raises an error when unexpected parameter is received' do
      expect { request.ranked '1', asd: 'foo' }.to raise_error ArgumentError
    end
  end

end
