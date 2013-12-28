require "spec_helper"
require "lol"

include Lol

describe Request do
  context "initialization" do
    it "requires an api_key parameter" do
      expect { ChampionRequest.new }.to raise_error(ArgumentError)
    end

    it "accepts a region parameter" do
      expect { ChampionRequest.new "foo" }.to raise_error(ArgumentError)
    end

    it "correctly sets api key" do
      expect(ChampionRequest.new("api_key", "euw").api_key).to eq("api_key")
    end
  end

  subject { Request.new "api_key", "euw"}

  describe "#perform_request" do

    let(:error401) { error_401 }

    it "calls HTTParty get" do
      expect(subject.class).to receive(:get).and_return(error401)
      expect { subject.perform_request "foo"}.to raise_error(InvalidAPIResponse)
    end

    it "handles 401" do
      expect(subject.class).to receive(:get).and_return(error401)
      expect { subject.perform_request "foo" }.to raise_error(InvalidAPIResponse)
    end

    it "handles 404" do
      expect(error401).to receive(:respond_to?).and_return(true)
      expect(error401).to receive(:not_found?).and_return(true)
      expect(subject.class).to receive(:get).and_return(error401)
      expect { subject.perform_request "foo"}.to raise_error(NotFound)
    end
  end

  describe "api_url" do
    it "defaults on Request#region" do
      expect(subject.api_url("bar")).to match(/\/euw\//)
    end

    it "defaults on Reques.api_version" do
      expect(subject.api_url("bar")).to match(/\/v1.1\//)
    end

    it "a path" do
      expect { subject.api_url }.to raise_error(ArgumentError)
    end

    it "returns a full fledged api url" do
      expect(subject.api_url("bar")).to eq("http://prod.api.pvp.net/api/lol/euw/v1.1/bar?api_key=api_key")
    end

    it "has lol if url is different from v2.1" do
      expect(subject.api_url("foo")).to eq("http://prod.api.pvp.net/api/lol/euw/v1.1/foo?api_key=api_key")
    end

    it "does not have lol only url is v2.1" do
      expect(Request).to receive(:api_version).at_least(:once).and_return("v2.1")
      expect(subject.api_url("foo")).to eq("http://prod.api.pvp.net/api/euw/v2.1/foo?api_key=api_key")
    end

    it "optionally accept query string parameters" do
      expect(subject.api_url("foo", a: 'b')).to eq("http://prod.api.pvp.net/api/lol/euw/v1.1/foo?a=b&api_key=api_key")
    end
  end
end
