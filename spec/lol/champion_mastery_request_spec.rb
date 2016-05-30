require "spec_helper"
require "lol"
require 'webmock'
include Lol

describe ChampionMasteryRequest do
  let(:request) { ChampionMasteryRequest.new("api_key", "euw") }

  it "inherits from Request" do
    expect(ChampionMasteryRequest.ancestors[1]).to eq(Request)
  end

  describe "#champion" do
    it 'requires a player_id' do
      expect { request.champion }.to raise_error ArgumentError
    end

    it 'requires a champion_id' do
      expect { request.champion }.to raise_error ArgumentError
    end

    it 'raises an error when unexpected parameter is received' do
      expect { request.champion '1', '1', asd: 'foo' }.to raise_error ArgumentError
    end

    context 'with summoner and champion' do
      subject { request.champion(1, 40) }

      let(:fixture) { load_fixture('champion-mastery-champion', ChampionMasteryRequest.api_version) }

      before(:each) { stub_request(request, 'champion-mastery-champion', 'player/1/champion/40') }

      it 'returns a ChampionMastery' do
        expect(subject).to be_a ChampionMastery
      end

      it 'fetches ChampionStatistics from the API' do
        expect(subject.highest_grade).to eq('S+')
        expect(subject.champion_points).to eq(34356)
        expect(subject.player_id).to eq(1)
        expect(subject.champion_points_until_next_level).to eq(0)
        expect(subject.chest_granted).to be(true)
        expect(subject.champion_level).to eq(5)
        expect(subject.tokens_earned).to eq(2)
        expect(subject.champion_id).to eq(40)
        expect(subject.champion_points_since_last_level).to eq(12756)
      end
    end
  end

  describe "#champions" do

    it 'requires a player_id' do
      expect { request.champion }.to raise_error ArgumentError
    end

    it 'raises an error when unexpected parameter is received' do
      expect { request.champion '1', '1', asd: 'foo' }.to raise_error ArgumentError
    end

    context 'with summoner' do
      subject { request.champions(1) }

      let(:fixture) { load_fixture('champion-mastery-champions', ChampionMasteryRequest.api_version) }

      before(:each) { stub_request(request, 'champion-mastery-champions', 'player/1/champions') }

      it 'returns an Array' do
        expect(subject).to be_a Array
      end

      it 'returns an array of ChampionMastery' do
        expect(subject.map(&:class).uniq).to eq [ChampionMastery]
      end

      it 'fetches PlayerStatistics from the API' do
        expect(subject.size).to eq(fixture.size)
      end
    end
  end

  describe "#score" do

    it 'requires a player_id' do
      expect { request.champion }.to raise_error ArgumentError
    end

    it 'raises an error when unexpected parameter is received' do
      expect { request.champion '1', '1', asd: 'foo' }.to raise_error ArgumentError
    end

    context 'with summoner' do
      subject { request.score(1) }

      before(:each) { stub_request_raw(request, '60', 'player/1/score') }

      it 'returns the score' do
        expect(subject).to eq(60)
      end
    end
  end

  describe "#top_champions" do

    it 'requires a player_id' do
      expect { request.champion }.to raise_error ArgumentError
    end

    it 'raises an error when unexpected parameter is received' do
      expect { request.champion '1', '1', asd: 'foo' }.to raise_error ArgumentError
    end

    context 'with summoner' do
      context 'with count' do
        subject { request.top_champions(1, count: 10) }

        let(:fixture) { load_fixture('champion-mastery-top-champions-10', ChampionMasteryRequest.api_version) }

        before(:each) { stub_request(request, 'champion-mastery-top-champions-10', 'player/1/topchampions', count: 10) }

        it 'returns an Array' do
          expect(subject).to be_a Array
        end

        it 'returns an array of ChampionMastery' do
          expect(subject.map(&:class).uniq).to eq [ChampionMastery]
        end

        it 'fetches PlayerStatistics from the API' do
          expect(subject.size).to eq(fixture.size)
        end
      end

      context 'without count' do
        subject { request.top_champions(1) }

        let(:fixture) { load_fixture('champion-mastery-top-champions', ChampionMasteryRequest.api_version) }

        before(:each) { stub_request(request, 'champion-mastery-top-champions', 'player/1/topchampions') }

        it 'returns an Array' do
          expect(subject).to be_a Array
        end

        it 'returns an array of ChampionMastery' do
          expect(subject.map(&:class).uniq).to eq [ChampionMastery]
        end

        it 'fetches PlayerStatistics from the API' do
          expect(subject.size).to eq(fixture.size)
        end
      end
    end
  end
end
