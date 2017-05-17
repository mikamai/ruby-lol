require "spec_helper"
require "lol"

include Lol

describe LeagueRequest do
  subject { LeagueRequest.new 'api_key', 'euw' }

  it 'inherits from V3 Request' do
    expect(LeagueRequest).to be < V3Request
  end

  describe '#find_challenger' do
    it 'returns a LeagueList' do
      stub_request subject, 'league-challenger', 'challengerleagues/by-queue/RANKED_SOLO_5x5'
      expect(subject.find_challenger).to be_a LeagueList
    end

    it 'finds the challenger league for the given queue' do
      stub_request subject, 'league-challenger', 'challengerleagues/by-queue/foo'
      subject.find_challenger queue: 'foo'
    end
  end

  describe '#find_master' do
    it 'returns a LeagueList' do
      stub_request subject, 'league-master', 'masterleagues/by-queue/RANKED_SOLO_5x5'
      expect(subject.find_master).to be_a LeagueList
    end

    it 'finds the master league for the given queue' do
      stub_request subject, 'league-master', 'masterleagues/by-queue/foo'
      subject.find_master queue: 'foo'
    end
  end

  describe '#summoner_leagues' do
    it 'returns an array of LeagueList objects' do
      stub_request subject, 'league-summoner', 'leagues/by-summoner/1'
      result = subject.summoner_leagues summoner_id: 1
      expect(result).to be_a Array
      expect(result.map(&:class).uniq).to eq [LeagueList]
    end
  end

  describe '#summoner_positions' do
    it 'returns an array of LeaguePosition objects' do
      stub_request subject, 'league-positions', 'positions/by-summoner/1'
      result = subject.summoner_positions summoner_id: 1
      expect(result).to be_a Array
      expect(result.map(&:class).uniq).to eq [LeaguePosition]
    end
  end
end
