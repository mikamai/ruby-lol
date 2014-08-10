require "spec_helper"
require "lol"

include Lol

describe LeagueRequest do
  it "inherits from Request" do
    expect(LeagueRequest.ancestors[1]).to eq(Request)
  end

  let(:request) { LeagueRequest.new "api_key", "euw" }

  describe "#get" do

    subject { request.get(123) }

    before(:each) { stub_request(request, 'league', 'league/by-summoner/123') }

    it "returns an hash of arrays of Leagues" do
      expect(subject.map {|k,v| v.map(&:class).uniq}.flatten).to eq([League])
    end
  end
end
