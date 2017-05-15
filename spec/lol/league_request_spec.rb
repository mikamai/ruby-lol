require "spec_helper"
require "lol"

include Lol

describe LeagueRequest do
  subject { LeagueRequest.new 'api_key', 'euw' }
  before do
    allow(subject).to receive(:warn_for_deprecation)
  end

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

  describe '#challenger' do
    it 'calls #find_challenger' do
      expect(subject).to receive(:find_challenger).with(queue: 'RANKED_FOO')
      subject.challenger 'RANKED_FOO'
    end

    it 'shows a deprecation warning' do
      expect(subject).to receive(:warn_for_deprecation)
      stub_request subject, 'league-challenger', 'challengerleagues/by-queue/RANKED_SOLO_5x5'
      subject.challenger 'RANKED_SOLO_5x5'
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

  describe '#master' do
    it 'calls #find_master' do
      expect(subject).to receive(:find_master).with(queue: 'RANKED_FOO')
      subject.master 'RANKED_FOO'
    end

    it 'shows a deprecation warning' do
      expect(subject).to receive(:warn_for_deprecation)
      stub_request subject, 'league-master', 'masterleagues/by-queue/RANKED_SOLO_5x5'
      subject.master 'RANKED_SOLO_5x5'
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

  describe '#get' do
    it 'returns a hash of summoner_id/Array<LeagueList>' do
      stub_request subject, 'league-summoner', 'leagues/by-summoner/123'
      result = subject.get 123
      expect(result.keys).to eq ["123"]
      expect(result.map {|_,v| v.map(&:class).uniq}.flatten).to eq([LeagueList])
    end

    it 'calls #summoner_leagues for each summoner' do
      expect(subject).to receive(:summoner_leagues).with(summoner_id: 123).and_return []
      expect(subject).to receive(:summoner_leagues).with(summoner_id: 456).and_return []
      subject.get 123, 456
    end

    it 'shows a deprecation warning' do
      stub_request subject, 'league-summoner', 'leagues/by-summoner/123'
      expect(subject).to receive(:warn_for_deprecation)
      subject.get 123
    end
  end

  describe '#get_entries' do
    it 'returns a hash of summoner_id/Array<LeagueList>' do
      stub_request subject, 'league-summoner', 'leagues/by-summoner/123'
      result = subject.get_entries 123
      expect(result.keys).to eq ["123"]
      expect(result.map {|_,v| v.map(&:class).uniq}.flatten).to eq([LeagueList])
    end

    it 'calls #summoner_leagues for each summoner' do
      expect(subject).to receive(:summoner_leagues).with(summoner_id: 123).and_return []
      expect(subject).to receive(:summoner_leagues).with(summoner_id: 456).and_return []
      subject.get_entries 123, 456
    end

    it 'shows a deprecation warning' do
      stub_request subject, 'league-summoner', 'leagues/by-summoner/123'
      expect(subject).to receive(:warn_for_deprecation)
      subject.get_entries 123
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
