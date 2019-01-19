require "spec_helper"
require "lol"

include Lol

describe LeagueRequest do
  subject { LeagueRequest.new 'api_key', 'euw' }
  let(:dummy_encrypted_summoner_id) { 'qHn0uNkpA1T-NqQ0zHTEqNh1BhH5SAsGWwkZsacbeKBqSdkUEaYOcYNjDomm60vMrLWHu4ulYg1C5Q' }

  it 'inherits from V3 Request' do
    expect(LeagueRequest).to be < Request
  end

  describe '#find_challenger' do
    it 'returns a DynamicModel' do
      stub_request subject, 'league-challenger', 'challengerleagues/by-queue/RANKED_SOLO_5x5'
      expect(subject.find_challenger).to be_a DynamicModel
    end

    it 'finds the challenger league for the given queue' do
      stub_request subject, 'league-challenger', 'challengerleagues/by-queue/foo'
      subject.find_challenger queue: 'foo'
    end
  end

  describe '#find_master' do
    it 'returns a LeagueList' do
      stub_request subject, 'league-master', 'masterleagues/by-queue/RANKED_SOLO_5x5'
      expect(subject.find_master).to be_a DynamicModel
    end

    it 'finds the master league for the given queue' do
      stub_request subject, 'league-master', 'masterleagues/by-queue/foo'
      subject.find_master queue: 'foo'
    end
  end

  # FIXME: I can't find this API neither in v3 nor in v4 :(
  describe '#summoner_leagues' do
    it 'returns an array of LeagueList objects' do
      stub_request subject, 'league-summoner', "leagues/by-summoner/#{dummy_encrypted_summoner_id}"
      result = subject.summoner_leagues encrypted_summoner_id: dummy_encrypted_summoner_id
      expect(result).to be_a Array
      expect(result.map(&:class).uniq).to eq [DynamicModel]
    end
  end

  describe '#summoner_positions' do
    it 'returns an array of DynamicModel objects' do
      stub_request subject, 'league-positions', "positions/by-summoner/#{dummy_encrypted_summoner_id}"
      result = subject.summoner_positions encrypted_summoner_id: dummy_encrypted_summoner_id
      expect(result).to be_a Array
      expect(result.map(&:class).uniq).to eq [DynamicModel]
    end
  end
end
