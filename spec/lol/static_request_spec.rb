require "spec_helper"
require "lol"

include Lol

describe StaticRequest do
  describe "api_version" do
    it "is v1" do
      expect(StaticRequest.api_version).to eq("v1")
    end
  end

  subject { StaticRequest.new "api_key", "euw" }

  describe "api_url" do
    it "contains a static-data path component" do
      expect(subject.api_url("foo")).to eq("http://prod.api.pvp.net/api/lol/static-data/euw/v1/foo?api_key=api_key")
    end
  end
end
