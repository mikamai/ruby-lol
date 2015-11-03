require "spec_helper"
require "lol"

include Lol

describe MatchListRequest do
  it "inherits from Request" do
    expect(MatchListRequest.ancestors[1]).to eq(Request)
  end

  let(:request) { MatchListRequest.new("api_key", "euw") }

  describe "#get" do
    subject { request.get(1) }

    before { stub_request(request, 'match_list', 'matchlist/by-summoner/1') }

    it 'returns an hash' do
      expect(subject).to be_a(Hash)
    end

    it 'fetches matches from the API' do
      fixture = load_fixture('match_list', MatchListRequest.api_version)
      expect(subject.keys).to match_array fixture.keys
    end
  end

end
