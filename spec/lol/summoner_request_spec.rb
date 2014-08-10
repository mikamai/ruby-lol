require "spec_helper"
require "lol"

include Lol

describe SummonerRequest do
  it "inherits from Request" do
    expect(SummonerRequest.ancestors[1]).to eq(Request)
  end

  let(:request) { SummonerRequest.new('api_key', 'euw') }

  describe "#by_name" do

    context 'regular arguments' do
      subject { request.by_name(['foo', 'bar']) }

      before(:each) { stub_request(request, 'summoner-by-name', 'summoner/by-name/foo,bar') }

      it "returns an array" do
        expect(subject).to be_a(Array)
      end

      it "returns an array of summoners" do
        expect(subject.map(&:class).uniq).to eq([Summoner])
      end
    end

    it 'escapes the given names' do
      stub_request(request, 'summoner-by-name', "summoner/by-name/f%C3%B2%C3%A5,f%C3%B9%C3%AE")
      request.by_name(['fòå', 'fùî'])
    end

    it 'downcase the given names' do
      stub_request(request, 'summoner-by-name', 'summoner/by-name/foo,bar')
      request.by_name('FoO', 'BAR')
    end

    it 'strips spaces from names' do
      stub_request(request, 'summoner-by-name', 'summoner/by-name/foo,bar')
      request.by_name('Fo o', 'b a r')
    end
  end

  describe "#name" do
    subject { request.name("foo", "bar") }

    before(:each) { stub_request(request, 'summoner-name', 'summoner/foo,bar/name') }

    it "returns an hash" do
      expect(subject).to be_a(Hash)
    end
  end

  describe "#get" do
    subject { request.get(["foo", "bar"]) }

    before(:each) { stub_request(request, 'summoner', 'summoner/foo,bar') }

    it "returns an array summoners" do
      expect(subject.map(&:class).uniq).to eq([Summoner])
    end
  end

  describe "#runes" do
    subject { request.runes(["foo", "bar"]) }

    before(:each) { stub_request(request, 'summoner-runes', 'summoner/foo,bar/runes') }

    it "returns an array of Hash" do
      expect(subject).to be_a(Hash)
    end

    it "returns an array of RunePages for each summoner in the hash" do
      expect(subject.map {|k,v| v}.flatten.map(&:class).uniq).to eq([RunePage])
    end
  end

  describe "#masteries" do
    subject { request.masteries(["foo", "bar"]) }

    before(:each) { stub_request(request, 'summoner-masteries', 'summoner/foo,bar/masteries') }

    it "returns an array of Hash" do
      expect(subject).to be_a(Hash)
    end

    it "returns an array of MasteryPage for each summoner in the hash" do
      expect(subject.map {|k,v| v}.flatten.map(&:class).uniq).to eq([MasteryPage])
    end
  end
end
