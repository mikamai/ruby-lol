require "lol"
require "spec_helper"
require "json"

include Lol

describe Client do
  subject { Client.new "foo" }

  describe "#new" do
    it "requires an API key argument" do
      expect { Client.new }.to raise_error(ArgumentError)
    end

    it "accepts a region argument" do
      expect { Client.new("foo", :region => "na") }.not_to raise_error
    end

    it "defaults on EUW as a region" do
      expect(subject.region).to eq("euw")
    end
  end

  describe "#champion" do
    it "defaults to v1.1" do
      expect(subject).to receive(:champion11)
      subject.champion
    end
  end

  describe "#champion11" do
    let(:client) { Client.new "foo" }

    subject do
      expect(client).to receive(:get).with(client.api_url("v1.1", "champion")).and_return(load_fixture("champion", "v1.1", "get"))

      client.champion11
    end

    it "returns an array" do
      expect(subject).to be_a(Array)
    end

    it "returns an array of champions" do
      expect(subject.map {|e| e.class}.uniq).to eq([Champion])
    end

    it "fetches champions from the API" do
      expect(subject.size).to eq(108)
    end
  end

  describe "#region" do
    it "returns current region" do
      expect(subject.region).to eq("euw")
    end

    it "can be set to a new region" do
      subject.region = "NA"
      expect(subject.region).to eq("NA")
    end
  end

  describe "#api_key" do
    it "returns an api key" do
      expect(subject.api_key).to eq("foo")
    end

    it "is read_only" do
      expect { subject.api_key = "bar" }.to raise_error(NoMethodError)
    end
  end

  describe "api_url" do
    it "defaults on Client#region" do
      expect(subject.api_url("foo", "bar")).to match(/\/euw\//)
    end

    it "requires a version and a path" do
      expect { subject.api_url("foo") }.to raise_error(ArgumentError)
    end

    it "returns a full fledged api url" do
      expect(subject.api_url("foo", "bar")).to eq("http://prod.api.pvp.net/api/lol/euw/foo/bar?api_key=foo")
    end
  end
end
