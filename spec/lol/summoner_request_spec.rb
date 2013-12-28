require "spec_helper"
require "lol"

include Lol

describe SummonerRequest do
  it "inherits from Request" do
    expect(SummonerRequest.ancestors[1]).to eq(Request)
  end

  let(:request)   { SummonerRequest.new "api_key", "euw" }
  let(:by_name)   { load_fixture("summoner-by-name", SummonerRequest.api_version, "get") }
  let(:name)      { load_fixture("summoner-name", SummonerRequest.api_version, "get") }
  let(:summoner)  { load_fixture("summoner", SummonerRequest.api_version, "get") }
  let(:runes)     { load_fixture("summoner-runes", SummonerRequest.api_version, "get") }
  let(:masteries) { load_fixture("summoner-masteries", SummonerRequest.api_version, "get") }

  describe "#by_name" do
    subject do
      expect(request.class).to receive(:get).with(request.api_url("summoner/by-name/foo")).and_return(by_name)

      request.by_name "foo"
    end

    it "returns a summoner" do
      expect(subject).to be_a(Summoner)
    end
  end

  describe "#name" do
    subject do
      expect(request.class).to receive(:get).with(request.api_url("summoner/foo,bar/name")).and_return(name)

      request.name "foo", "bar"
    end

    it "returns an array of hashes" do
      expect(subject.map(&:class).uniq).to eq([Hash])
    end
  end

  describe "#get" do
    subject do
      expect(request.class).to receive(:get).with(request.api_url("summoner/foo")).and_return(summoner)

      request.get "foo"
    end

    it "returns a summoners" do
      expect(subject).to be_a(Summoner)
    end
  end

  describe "#runes" do
    subject do
      expect(request.class).to receive(:get).with(request.api_url("summoner/foo/runes")).and_return(runes)

      request.runes "foo"
    end

    it "returns an array of RunePage" do
      expect(subject.map(&:class).uniq).to eq([RunePage])
    end
  end

  describe "#masteries" do
    subject do
      expect(request.class).to receive(:get).with(request.api_url("summoner/foo/masteries")).and_return(masteries)

      request.masteries "foo"
    end

    it "returns an array of MasteryPage" do
      expect(subject.map(&:class).uniq).to eq([MasteryPage])
    end
  end
end
