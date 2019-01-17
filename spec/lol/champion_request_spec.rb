require "spec_helper"
require "lol"

include Lol

describe ChampionRequest do
  subject { described_class.new("api_key", "euw") }

  it "inherits from Request" do
    expect(described_class.ancestors[1]).to eq(Request)
  end

  it "still has only the v3" do
    expect(described_class.api_version).to eq('v3')
  end

  describe "#find" do
    it "returns a champion" do
      stub_request subject, 'champion-266', 'champions/266'
      expect(subject.find 266).to be_a DynamicModel
    end
  end

  describe "#all" do
    before { stub_request subject, 'champion-all', 'champions', 'freeToPlay' => false }
    let(:result) { subject.all }

    it "returns an array of champions" do
      expect(result).to be_a Array
      expect(result.map(&:class).uniq).to eq [DynamicModel]
    end

    it "fetches champions from the API" do
      expect(result.size).to eq load_fixture('champion-all', described_class.api_version)['champions'].size
    end
  end
end
