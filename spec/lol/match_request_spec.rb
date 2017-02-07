require "spec_helper"
require "lol"

include Lol

describe MatchRequest do
  it "inherits from Request" do
    expect(MatchRequest.ancestors[1]).to eq(Request)
  end

  let(:request) { MatchRequest.new("api_key", "euw") }

  describe "#get" do
    subject { request.get(1) }

    before { stub_request(request, 'match', 'match/1') }

    it 'returns an hash' do
      expect(subject).to be_a(Hash)
    end

    it 'fetches matches from the API' do
      fixture = load_fixture('match', MatchRequest.api_version)
      expect(subject.keys).to match_array fixture.keys
    end
  end

  describe '#by_tournament' do
    subject { request.by_tournament 'CODE-FOR-TEST' }

    before { stub_request(request, 'match-by-tournament', 'match/by-tournament/CODE-FOR-TEST/ids') }

    it 'returns an Array' do
      expect(subject).to be_a(Array)
    end
  end

  describe '#for_tournament' do
    subject { request.for_tournament 1, 'CODE-FOR-TEST' }

    before { stub_request(request, 'match', 'match/for-tournament/1?tournamentCode=CODE-FOR-TEST') }

    it 'returns an hash' do
      expect(subject).to be_a(Hash)
    end
    
    it 'fetches matches from the API' do
      fixture = load_fixture('match', MatchRequest.api_version)
      expect(subject.keys).to match_array fixture.keys
    end
  end
end
