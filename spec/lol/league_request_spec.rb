require "spec_helper"
require "lol"

include Lol

describe LeagueRequest do
  it "inherits from Request" do
    expect(LeagueRequest.ancestors[1]).to eq(Request)
  end

  let(:request) { LeagueRequest.new("api_key", "euw") }

  describe "#get" do
    subject { request.get(123) }

    let(:fixture) { load_fixture('league', request.class.api_version, 'get') }

    before(:each) { stub_request(request, 'league', 'league/by-summoner/123') }

    it "returns a hash of arrays of Leagues" do
      expect(subject.map {|_,v| v.map(&:class).uniq}.flatten).to eq([League])
    end

    it 'has hash keys with string summoner ids' do
      expect(subject.keys).to eq(fixture.keys)
    end
  end

  describe "#get_entries" do
    subject { request.get_entries(123) }

    let(:fixture) { load_fixture('league-entry', request.class.api_version, 'get') }

    before(:each) { stub_request(request, 'league-entry', 'league/by-summoner/123/entry') }

    it 'returns a hash of arrays of Leagues' do
      expect(subject.map {|_,v| v.map(&:class).uniq}.flatten).to eq([League])
    end

    it 'has hash keys with summoner ids' do
      expect(subject.keys).to eq(fixture.keys)
    end
  end

  describe '#by_team' do
    subject { request.by_team('TEAM-7d7013d0-b38b-11e3-9e38-782bcb497d6f') }

    let(:fixture) { load_fixture('league-by-team', request.class.api_version, 'get') }

    before(:each) { stub_request(request, 'league-by-team', 'league/by-team/TEAM-7d7013d0-b38b-11e3-9e38-782bcb497d6f') }

    it 'returns a hash of arrays of Leagues' do
      expect(subject.map {|_,v| v.map(&:class).uniq}.flatten).to eq([League])
    end

    it 'has hash keys with string team id' do
      expect(subject.keys).to eq(fixture.keys)
    end
  end

  describe '#entries_by_team' do
    subject { request.entries_by_team('TEAM-7d7013d0-b38b-11e3-9e38-782bcb497d6f') }

    let(:fixture) { load_fixture('league-entry-by-team', request.class.api_version, 'get') }

    before(:each) { stub_request(request, 'league-entry-by-team', 'league/by-team/TEAM-7d7013d0-b38b-11e3-9e38-782bcb497d6f/entry') }

    it 'returns a hash of arrays of Leagues' do
      expect(subject.map {|_,v| v.map(&:class).uniq}.flatten).to eq([League])
    end

    it 'has hash keys with string team id' do
      expect(subject.keys).to eq(fixture.keys)
    end
  end

  describe '#challenger' do
    subject { request.challenger }

    before(:each) { stub_request(request, 'league-challenger', 'league/challenger') }

    it 'returns League' do
      expect(subject.class).to eq(League)
    end
  end

end
