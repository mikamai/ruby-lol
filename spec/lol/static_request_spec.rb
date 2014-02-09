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
          let(:fixtures) { load_fixture("#{endpoint.dasherize}", StaticRequest.api_version, "get") }

          subject do
            expect(request).to receive(:perform_request)
              .with(request.api_url("#{endpoint.dasherize}"))
              .and_return(fixtures)

            request.send(endpoint).get
          end

          it "returns an Array" do
            expect(subject).to be_an(Array)
          end

          it "returns an Array of OpenStructs" do
            expect(subject.map(&:class).uniq).to eq([OpenStruct])
          end

          it "fetches #{endpoint} from the API" do
            expect(subject.size).to eq(fixtures["data"].size)
          end
        end

        context "with_id" do
          let(:id) { 1 }
          let(:fixtures) { load_fixture("#{endpoint.dasherize}-by-id", StaticRequest.api_version, "get") }

          subject do
            expect(request).to receive(:perform_request)
              .with(request.api_url("#{endpoint.dasherize}/#{id}"))
              .and_return(fixtures)

            request.send(endpoint).get(id)
          end

          it "returns an OpenStruct" do
            expect(subject).to be_an(OpenStruct)
          end
        end
      end
    end
  end

  describe "realm" do
    let(:fixtures) { load_fixture("realm", StaticRequest.api_version, "get") }

    subject do
      expect(request).to receive(:perform_request)
        .with(request.api_url("realm"))
        .and_return(fixtures)

      request.send("realm").get
    end

    it "returns an OpenStruct" do
      expect(subject).to be_an(OpenStruct)
    end
  end
end
