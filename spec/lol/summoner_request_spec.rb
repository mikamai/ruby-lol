require "spec_helper"
require "lol"

include Lol

describe SummonerRequest do
  it "inherits from Request" do
    expect(SummonerRequest.ancestors[1]).to eq(Request)
  end

  let(:request)   { SummonerRequest.new "api_key", "euw" }
  let(:by_name)   { load_fixture("summoner-by-name", "v1.1", "get") }
  let(:name)      { load_fixture("summoner-name", "v1.1", "get") }
  let(:summoner)  { load_fixture("summoner", "v1.1", "get") }
  let(:runes)     { load_fixture("summoner-runes", "v1.1", "get") }
  let(:masteries) { load_fixture("summoner-masteries", "v1.1", "get") }

  describe "#by_name" do
    subject do
      expect(request.class).to receive(:get).with(request.api_url("v1.1", "summoner/by-name/foo")).and_return(by_name)

      request.by_name "foo"
    end

    it "returns a summoner" do
      expect(subject).to be_a(Summoner)
    end
  end

  describe "#name" do
    subject do
      expect(request.class).to receive(:get).with(request.api_url("v1.1", "summoner/foo,bar/name")).and_return(name)

      request.name "foo", "bar"
    end

    it "returns an array of hashes" do
      expect(subject.map(&:class).uniq).to eq([Hash])
    end
  end

  describe "#get" do
    subject do
      expect(request.class).to receive(:get).with(request.api_url("v1.1", "summoner/foo")).and_return(summoner)

      request.get "foo"
    end

    it "returns a summoners" do
      expect(subject).to be_a(Summoner)
    end
  end

  describe "#runes" do
    subject do
      expect(request.class).to receive(:get).with(request.api_url("v1.1", "summoner/foo/runes")).and_return(runes)

      request.runes "foo"
    end

    it "returns an array of RunePage" do
      expect(subject.map(&:class).uniq).to eq([RunePage])
    end
  end

  describe "#masteries" do
    subject do
      expect(request.class).to receive(:get).with(request.api_url("v1.1", "summoner/foo/masteries")).and_return(masteries)

      request.masteries "foo"
    end

    it "returns an array of MasteryPage" do
      expect(subject.map(&:class).uniq).to eq([MasteryPage])
    end
  end
end
