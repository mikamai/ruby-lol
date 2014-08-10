require "spec_helper"
require "lol"

include Lol

describe ChampionRequest do
  it "inherits from Request" do
    expect(ChampionRequest.ancestors[1]).to eq(Request)
  end

  let(:request) { ChampionRequest.new("api_key", "euw") }

  describe "#get" do

    context "specifying an id" do
      subject { request.get(:id => 266) }

      before(:each) { stub_request(request, 'champion-266', 'champion/266', 'freeToPlay' => false) }

      it "returns a champion" do
        expect(subject).to be_a(Champion)
      end
    end

    context "getting all" do
      subject { request.get }

      before(:each) { stub_request(request, 'champion', 'champion', 'freeToPlay' => false) }

      it "returns an array" do
        expect(subject).to be_a(Array)
      end

      it "returns an array of champions" do
        expect(subject.map {|e| e.class}.uniq).to eq([Champion])
      end

      it "fetches champions from the API" do
        expect(subject.size).to eq(load_fixture("champion", ChampionRequest.api_version)["champions"].size)
      end

    end


  end
end
