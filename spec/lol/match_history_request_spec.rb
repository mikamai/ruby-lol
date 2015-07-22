require "spec_helper"
require "lol"

include Lol

describe MatchHistoryRequest do
  it "inherits from Request" do
    expect(MatchHistoryRequest.ancestors[1]).to eq(Request)
  end

  let(:request) { MatchHistoryRequest.new("api_key", "euw") }

  describe "#get" do
    subject { request.get(1) }

    before { stub_request(request, 'match_history', 'matchhistory/1') }

    it 'returns an hash' do
      expect(subject).to be_a(Hash)
    end

    it 'fetches matches from the API' do
      fixture = load_fixture('match_history', MatchHistoryRequest.api_version)
      expect(subject.keys).to match_array fixture.keys
    end
  end

end
