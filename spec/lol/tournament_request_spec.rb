require "spec_helper"
require "lol"

include Lol

describe TournamentRequest do
  subject { described_class.new "api_key", "euw" }
  before { allow(subject).to receive(:warn_for_deprecation) }

  it "inherits from V3Request" do
    expect(TournamentRequest).to be < V3Request
  end

  describe "#create_provider" do
    it "returns the provider id" do
      expect(subject).to receive(:perform_request).with(instance_of(String), :post, { "url" => "https://foo.com", "region" => "EUW" }).and_return 10
      expect(subject.create_provider url: "https://foo.com").to eq 10
    end
  end

  describe "#provider" do
    it "calls #create_provider" do
      expect(subject).to receive(:create_provider)
      subject.provider "https://foo.com", "euw"
    end

    it "shows a deprecation warning" do
      allow(subject).to receive(:perform_request)
      expect(subject).to receive(:warn_for_deprecation)
      subject.provider "https://foo.com", "euw"
    end
  end

  describe "#create_tournament" do
    it "returns the tournament id" do
      expect(subject).to receive(:perform_request).with(instance_of(String), :post, { "providerId" => 10, "name" => "ASD" }).and_return 10
      expect(subject.create_tournament provider_id: 10, name: "ASD").to eq 10
    end
  end

  describe "#tournament" do
    it "calls #create_tournament" do
      expect(subject).to receive(:create_tournament)
      subject.tournament "foo", 10
    end

    it "shows a deprecation warning" do
      allow(subject).to receive(:perform_request)
      expect(subject).to receive(:warn_for_deprecation)
      subject.tournament "foo", 10
    end
  end

  describe "#find_code" do
    it "returns a DynamicModel" do
      stub_request subject, "tournament-code", "codes/foo"
      expect(subject.find_code 'foo').to be_a DynamicModel
    end
  end

  describe "#get_code" do
    it "calls #find_code" do
      expect(subject).to receive(:find_code)
      subject.get_code 'foo'
    end

    it "shows a deprecation warning" do
      expect(subject).to receive(:find_code)
      expect(subject).to receive(:warn_for_deprecation)
      subject.get_code 'foo'
    end
  end

  pending '#create_codes'
  pending '#update_code'
end
