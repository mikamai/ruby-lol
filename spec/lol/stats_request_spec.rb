require "spec_helper"
require "lol"

include Lol

describe StatsRequest do
  let(:request) { StatsRequest.new("api_key", "euw") }

  it "inherits from Request" do
    expect(GameRequest.ancestors[1]).to eq(Request)
  end

  describe "#summary" do

    it 'requires a summoner' do
      expect { request.summary }.to raise_error ArgumentError
    end

    it 'raises an error when unexpected parameter is received' do
      expect { request.summary '1', asd: 'foo' }.to raise_error ArgumentError
    end

    context 'with summoner' do
      subject { request.summary(1) }

      context 'without season' do
        let(:fixture) { load_fixture('stats', StatsRequest.api_version, 'get') }

        before(:each) { stub_request(request, 'stats', 'stats/by-summoner/1/summary') }

        it 'returns an array' do
          expect(subject).to be_a Array
        end

        it 'returns an array of PlayerStatistic' do
          expect(subject.map(&:class).uniq).to eq [PlayerStatistic]
        end

        it 'fetches PlayerStatistics from the API' do
          expect(subject.size).to eq(fixture['playerStatSummaries'].size)
        end
      end

      context 'with season' do
        before(:each) { stub_request(request, 'stats', 'stats/by-summoner/1/summary', season: '1') }

        it 'optionally accepts a season' do
          request.summary('1', season: '1')
        end
      end

    end
  end

  describe "#ranked" do

    it 'requires a summoner' do
      expect { request.ranked }.to raise_error ArgumentError
    end

    it 'raises an error when unexpected parameter is received' do
      expect { request.ranked '1', asd: 'foo' }.to raise_error ArgumentError
    end

    context 'with summoner' do
      let(:fixture) { load_fixture 'ranked_stats', StatsRequest.api_version, 'get' }

      context 'without season' do
        subject { request.ranked(1) }

        before(:each) { stub_request(request, 'ranked_stats', 'stats/by-summoner/1/ranked') }

        it 'returns a RankedStatisticsSummary' do
          expect(subject).to be_a RankedStatisticsSummary
        end

        it 'fetches RankedStatisticsSummary from the API' do
          expect(subject.champions.size).to eq(fixture['champions'].size)
        end
      end

      context 'with season' do
        before(:each) { stub_request(request, 'ranked_stats', 'stats/by-summoner/1/ranked', season: '1') }

        it 'optionally accepts a season' do
          request.ranked('1', season: '1')
        end
      end
    end

  end

end
