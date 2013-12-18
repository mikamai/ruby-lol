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
      expect(subject.api_url("foo", "bar")).to match(/\/euw\//)
    end

    it "requires an api_key a version and a path" do
      expect { subject.api_url "foo" }.to raise_error(ArgumentError)
    end

    it "returns a full fledged api url" do
      expect(subject.api_url("foo", "bar")).to eq("http://prod.api.pvp.net/api/euw/foo/bar?api_key=api_key")
    end

    it "has lol if url is v1.1" do
      expect(subject.api_url("v1.1", "foo")).to eq("http://prod.api.pvp.net/api/lol/euw/v1.1/foo?api_key=api_key")
    end

    it "does not have lol if url is v2.1 or greater" do
      expect(subject.api_url("v2.1", "foo")).to eq("http://prod.api.pvp.net/api/euw/v2.1/foo?api_key=api_key")
    end

    it "optionally accept query string parameters" do
      expect(subject.api_url("v2.1", "foo", a: 'b')).to eq("http://prod.api.pvp.net/api/euw/v2.1/foo?a=b&api_key=api_key")
    end
  end
end
