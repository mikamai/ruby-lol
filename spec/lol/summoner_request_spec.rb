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
      expect(request.class).to receive(:get).with(request.api_url("summoner/by-name/foo,bar")).and_return(by_name)

      request.by_name ["foo", "bar"]
    end

    it "returns an array" do
      expect(subject).to be_a(Array)
    end

    it "returns an array of summoners" do
      expect(subject.map(&:class).uniq).to eq([Summoner])
    end

    it 'escapes the given names' do
      expect(request.class).to receive(:get).with(request.api_url("summoner/by-name/f%C3%B2%C3%A5,f%C3%B9%C3%AE")).and_return(by_name)
      request.by_name ['fòå', 'fùî']
    end

    it 'raises an error if no name is given' do
      expect { request.by_name }.to raise_error ArgumentError
    end
  end

  describe "#name" do
    subject do
      expect(request.class).to receive(:get).with(request.api_url("summoner/foo,bar/name")).and_return(name)

      request.name "foo", "bar"
    end

    it "returns an hash" do
      expect(subject).to be_a(Hash)
    end

    it 'raises an error if no summoner id is given' do
      expect { request.name }.to raise_error ArgumentError
    end
  end

  describe "#get" do
    subject do
      expect(request.class).to receive(:get).with(request.api_url("summoner/foo,bar")).and_return(summoner)

      request.get ["foo", "bar"]
    end

    it "returns an array summoners" do
      expect(subject.map(&:class).uniq).to eq([Summoner])
    end

    it 'raises an error if no id is given' do
      expect { request.get }.to raise_error ArgumentError
    end
  end

  describe "#runes" do
    subject do
      expect(request.class).to receive(:get).with(request.api_url("summoner/foo,bar/runes")).and_return(runes)

      request.runes ["foo", "bar"]
    end

    it "returns an array of Hash" do
      expect(subject).to be_a(Hash)
    end

    it "returns an array of RunePages for each summoner in the hash" do
      expect(subject.map {|k,v| v}.flatten.map(&:class).uniq).to eq([RunePage])
    end

    it 'raises an error if no id is given' do
      expect { request.runes }.to raise_error ArgumentError
    end
  end

  describe "#masteries" do
    subject do
      expect(request.class).to receive(:get).with(request.api_url("summoner/foo,bar/masteries")).and_return(masteries)

      request.masteries ["foo", "bar"]
    end

    it "returns an array of Hash" do
      expect(subject).to be_a(Hash)
    end

    it "returns an array of MasteryPage for each summoner in the hash" do
      expect(subject.map {|k,v| v}.flatten.map(&:class).uniq).to eq([MasteryPage])
    end

    it 'raises an error if no id is given' do
      expect { request.masteries }.to raise_error ArgumentError
    end
  end
end
