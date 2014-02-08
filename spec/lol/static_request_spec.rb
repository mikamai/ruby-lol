require "spec_helper"
require "lol"

include Lol

describe StaticRequest do
  describe "api_version" do
    it "is v1" do
      expect(StaticRequest.api_version).to eq("v1")
    end
  end

  let(:request) { StaticRequest.new "api_key", "euw" }

  describe "api_url" do
    it "contains a static-data path component" do
      expect(request.api_url("foo")).to eq("http://prod.api.pvp.net/api/lol/static-data/euw/v1/foo?api_key=api_key")
    end
  end

  describe "endpoints" do

    StaticRequest::ENDPOINTS.each do |endpoint|
      it "returns a Proxy for each endpoint" do
        expect(request.send(endpoint).class).to eq(StaticRequest::Proxy)
      end

      it "proxies get to StaticRequest with the correct endpoint" do
        expect(request).to receive(:get).with(endpoint)

        request.send(endpoint).get
      end
    end
  end
end
