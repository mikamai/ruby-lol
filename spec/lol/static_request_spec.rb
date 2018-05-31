require "spec_helper"
require "lol"

include Lol

describe StaticRequest do
  let(:subject) { StaticRequest.new("api_key", "euw") }

  {
    "champion"       => "champions",
    "item"           => "items",
    "mastery"        => "masteries",
    "rune"           => "runes",
    "summoner_spell" => "summoner_spells"
  }.each do |old_edpoint, new_endpoint|
    describe "##{new_endpoint}" do
      it "returns a Proxy" do
        expect(subject.send(new_endpoint).class).to eq(StaticRequest::Proxy)
      end

      describe "#get" do
        let(:fixture_name) { "static-#{new_endpoint.dasherize}" }

        it "proxies get to StaticRequest with the correct endpoint" do
          expect(subject).to receive(:get).with(new_endpoint, anything, anything)
          subject.send(new_endpoint).get
        end

        context "without an id" do
          let(:fixture) { load_fixture(fixture_name, StaticRequest.api_version) }

          let(:result) { subject.public_send(new_endpoint).get }

          before { stub_request(subject, fixture_name, "#{new_endpoint.dasherize}") }

          it "returns an Array of OpenStruct" do
            expect(result).to be_a Array
            expect(result.map(&:class).uniq).to eq([OpenStruct])
          end

          it "fetches #{new_endpoint} from the API" do
            expect(result.size).to eq(fixture["data"].size)
          end
        end

        context "with an id" do
          it "returns an OpenStruct" do
            stub_request(subject, "#{fixture_name}-by-id", "#{new_endpoint.dasherize}/1")
            expect(subject.public_send(new_endpoint).get 1).to be_a OpenStruct
          end
        end
      end
    end
  end

  describe "#reforged_runes" do
    it "returns a Proxy" do
      expect(subject.reforged_runes.class).to eq(StaticRequest::Proxy)
    end

    describe "#get" do
      let(:fixture_name) { "static-reforged-runes" }

      it "proxies get to StaticRequest with the correct endpoint" do
        expect(subject).to receive(:get).with('reforged_runes', anything, anything)
        subject.reforged_runes.get
      end

      context "without an id" do
        let(:fixture) { load_fixture(fixture_name, StaticRequest.api_version) }

        let(:result) { subject.reforged_runes.get }

        before { stub_request(subject, fixture_name, "reforged-runes") }

        it "returns an Array of OpenStruct" do
          expect(result).to be_a Array
          expect(result.map(&:class).uniq).to eq([OpenStruct])
        end

        it "fetches reforged_runes from the API" do
          expect(result.size).to eq(fixture.size)
        end
      end

      context "with an id" do
        it "returns an OpenStruct" do
          stub_request(subject, "#{fixture_name}-by-id", "reforged-runes/1")
          expect(subject.reforged_runes.get 1).to be_a OpenStruct
        end
      end
    end
  end

  describe "#maps" do
    let(:result) { subject.maps.get }

    before(:each) { stub_request(subject, 'static-maps', 'maps') }

    it "returns an Array of OpenStructs" do
      expect(result).to be_a Array
      expect(result.map(&:class).uniq).to eq [OpenStruct]
    end
  end

  describe "#realms" do
    let(:result) { subject.realms.get }

    before(:each) { stub_request(subject, 'static-realms', 'realms') }

    it "returns an OpenStruct" do
      expect(result).to be_a OpenStruct
    end
  end

  describe "#versions" do
    let(:result) { subject.versions.get }

    before(:each) { stub_request(subject, 'static-versions', 'versions') }

    it "returns an Array" do
      expect(result).to be_an(Array)
    end
  end

end
