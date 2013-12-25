require "spec_helper"
require "lol"

include Lol

describe LeagueRequest do
  it "inherits from Request" do
    expect(LeagueRequest.ancestors[1]).to eq(Request)
  end

  describe "#get" do
    let(:request) { LeagueRequest.new "api_key", "euw" }

    subject do
      expect(request.class).to receive(:get).with(request.api_url("v2.2", "league/by-summoner/123")).and_return(load_fixture("league", "v2.2", "get"))

      request.get(123)
    end

    it "returns an array of Leagues" do
      expect(subject.map(&:class).uniq).to eq([League])
    end
  end
end
