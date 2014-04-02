require "spec_helper"
require "lol"

include Lol

describe ChampionRequest do
  it "inherits from Request" do
    expect(ChampionRequest.ancestors[1]).to eq(Request)
  end

  describe "get" do
    let(:request) { ChampionRequest.new "api_key", "euw" }

    context "specifying an id" do
      subject do
        expect(request).to receive(:perform_request).with(request.api_url("champion/266", "freeToPlay" => false)).and_return(load_fixture("champion-266", ChampionRequest.api_version, "get"))

        request.get :id => 266
      end

      it "returns a champion" do
        expect(subject).to be_a(Champion)
      end
    end

    context "getting all" do
      subject do
        expect(request).to receive(:perform_request).with(request.api_url("champion", "freeToPlay" => false)).and_return(load_fixture("champion", ChampionRequest.api_version, "get"))

        request.get
      end

      it "returns an array" do
        expect(subject).to be_a(Array)
      end

      it "returns an array of champions" do
        expect(subject.map {|e| e.class}.uniq).to eq([Champion])
      end

      it "fetches champions from the API" do
        expect(subject.size).to eq(load_fixture("champion", ChampionRequest.api_version, "get")["champions"].size)
      end

    end


  end
end
