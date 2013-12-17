require "spec_helper"
require "lol"

include Lol

describe ChampionRequest do
  it "inherits from Request" do
    expect(ChampionRequest.ancestors[1]).to eq(Request)
  end

  describe "get" do
    let(:request) { ChampionRequest.new "api_key", "euw" }

    subject do
      expect(request).to receive(:perform_request).with(request.api_url("v1.1", "champion")).and_return(load_fixture("champion", "v1.1", "get"))

      request.get
    end

    it "returns an array" do
      expect(subject).to be_a(Array)
    end

    it "returns an array of champions" do
      expect(subject.map {|e| e.class}.uniq).to eq([Champion])
    end

    it "fetches champions from the API" do
      expect(subject.size).to eq(load_fixture("champion", "v1.1", "get")["champions"].size)
    end
  end
end
