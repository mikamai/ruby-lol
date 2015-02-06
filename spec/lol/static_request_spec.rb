require "spec_helper"
require "lol"

include Lol

describe StaticRequest do
  describe "api_version" do
    it "is v1.2" do
      expect(StaticRequest.api_version).to eq("v1.2")
    end
  end

  let(:request) { StaticRequest.new("api_key", "euw") }

  describe "#api_url" do
    it "contains a static-data path component" do
      expect(request.api_url("foo")).to eq("https://global.api.pvp.net/api/lol/static-data/euw/v1.2/foo?api_key=api_key")
    end
  end

  StaticRequest::STANDARD_ENDPOINTS.each do |endpoint|
    describe "##{endpoint}" do
      it "returns a Proxy" do
        expect(request.send(endpoint).class).to eq(StaticRequest::Proxy)
      end

      describe "#get" do
        it "proxies get to StaticRequest with the correct endpoint" do
          expect(request).to receive(:get).with(endpoint, anything, anything)

          request.send(endpoint).get
        end

        context "without_id" do

          let(:fixture_name) { endpoint == 'champion' ? 'static-champion' : endpoint.dasherize }
          let(:fixture) { load_fixture(fixture_name, StaticRequest.api_version) }

          subject { request.public_send(endpoint).get }

          before(:each) { stub_request(request, fixture_name, "#{endpoint.dasherize}") }

          it "returns an Array" do
            expect(subject).to be_an(Array)
          end

          it "returns an Array of OpenStructs" do
            expect(subject.map(&:class).uniq).to eq([OpenStruct])
          end

          it "fetches #{endpoint} from the API" do
            expect(subject.size).to eq(fixture["data"].size)
          end
        end

        context "with_id" do
          let(:id) { 1 }

          before(:each) { stub_request(request, "#{endpoint.dasherize}-by-id", "#{endpoint.dasherize}/#{id}") }

          subject { request.public_send(endpoint).get(id) }

          it "returns an OpenStruct" do
            expect(subject).to be_an(OpenStruct)
          end
        end
      end
    end
  end

  describe "#realm" do
    subject { request.realm.get }

    before(:each) { stub_request(request, 'realm', 'realm') }

    it "returns an OpenStruct" do
      expect(subject).to be_an(OpenStruct)
    end
  end

  describe "#versions" do
    subject { request.versions.get }

    before(:each) { stub_request(request, 'versions', 'versions') }

    it "returns an Array" do
      expect(subject).to be_an(Array)
    end
  end

end
