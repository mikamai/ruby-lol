require "spec_helper"
require "lol"

include Lol

describe TournamentRequest do
  subject { described_class.new "api_key", "euw" }

  it "inherits from Request" do
    expect(TournamentRequest).to be < Request
  end

  describe "#create_provider" do
    it "returns the provider id" do
      expect(subject).to receive(:perform_request).with(instance_of(String), :post, { "url" => "https://foo.com", "region" => "EUW" }).and_return 10
      expect(subject.create_provider url: "https://foo.com").to eq 10
    end
  end

  describe "#create_tournament" do
    it "returns the tournament id" do
      expect(subject).to receive(:perform_request).with(instance_of(String), :post, { "providerId" => 10, "name" => "ASD" }).and_return 10
      expect(subject.create_tournament provider_id: 10, name: "ASD").to eq 10
    end
  end

  describe "#find_code" do
    it "returns a DynamicModel" do
      stub_request subject, "tournament-code", "codes/foo"
      expect(subject.find_code 'foo').to be_a DynamicModel
    end
  end

  pending '#create_codes'
  pending '#update_code'
end
