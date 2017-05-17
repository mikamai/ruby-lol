require "spec_helper"
require "lol"

include Lol

describe SummonerRequest do
  subject { SummonerRequest.new "api_key", "euw" }
  before { allow(subject).to receive(:warn_for_deprecation) }

  it "inherits from V3Request" do
    expect(SummonerRequest).to be < V3Request
  end

  describe "#find" do
    it "returns a DynamicModel" do
      stub_request subject, "summoner", "summoners/23"
      expect(subject.find 23).to be_a DynamicModel
    end
  end

  describe "#get" do
    it "returns an Array" do
      stub_request subject, "summoner", "summoners/23"
      expect(subject.get 23).to be_a Array
    end

    it "calls #find" do
      expect(subject).to receive(:find).with 23
      subject.get 23
    end

    it "calls #find with each given id" do
      expect(subject).to receive(:find).with 22
      expect(subject).to receive(:find).with 23
      subject.get 22, 23
    end

    it "shows a deprecation warning" do
      expect(subject).to receive(:warn_for_deprecation)
      stub_request subject, "summoner", "summoners/23"
      subject.get 23
    end
  end

  describe "#name" do
    it "returns an Hash" do
      stub_request subject, "summoner", "summoners/23"
      result = subject.name(23)
      expect(result).to be_a Hash
      expect(result[23]).to be_a String
    end

    it "calls #find" do
      expect(subject).to receive(:find).with(23).and_return OpenStruct.new(name: 'foo')
      subject.name 23
    end

    it "calls #find with each given id" do
      expect(subject).to receive(:find).with(22).and_return OpenStruct.new(name: 'bar')
      expect(subject).to receive(:find).with(23).and_return OpenStruct.new(name: 'baz')
      subject.name 22, 23
    end

    it "shows a deprecation warning" do
      expect(subject).to receive(:warn_for_deprecation)
      stub_request subject, "summoner", "summoners/23"
      subject.name 23
    end
  end

  describe "#find_by_name" do
    it "returns a DynamicModel" do
      stub_request subject, 'summoner-by-name', 'summoners/by-name/foo'
      expect(subject.find_by_name 'foo').to be_a DynamicModel
    end

    it "escapes the given name" do
      stub_request subject, 'summoner-by-name', 'summoners/by-name/f%C3%B2%C3%A5'
      subject.find_by_name 'fòå'
    end

    it "downcases the given name" do
      stub_request subject, 'summoner-by-name', 'summoners/by-name/arg'
      subject.find_by_name 'ARG'
    end

    it 'strips spaces from names' do
      stub_request(subject, 'summoner-by-name', 'summoners/by-name/foo')
      subject.find_by_name('fo o')
    end
  end

  describe "#by_name" do
    it "returns an Array" do
      stub_request(subject, 'summoner-by-name', 'summoners/by-name/foo')
      expect(subject.by_name 'foo').to be_a Array
    end

    it "calls #find_by_name" do
      expect(subject).to receive(:find_by_name).with 'foo'
      subject.by_name 'foo'
    end

    it "calls #find_by_name with each given name" do
      expect(subject).to receive(:find_by_name).with 'foo'
      expect(subject).to receive(:find_by_name).with 'bar'
      subject.by_name 'foo', 'bar'
    end

    it "shows a deprecation warning" do
      expect(subject).to receive(:warn_for_deprecation)
      stub_request(subject, 'summoner-by-name', 'summoners/by-name/foo')
      subject.by_name 'foo'
    end
  end
end
