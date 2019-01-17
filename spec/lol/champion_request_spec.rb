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

  describe "#champion_rotation" do
    before do
      stub_request subject, 'champion-rotations', 'champion-rotations'
    end

    it "returns the current champion rotation" do
      expect(subject.champion_rotations).to be_a DynamicModel
    end

    it { expect(subject.champion_rotations.free_champion_ids).to be_a Array }
    it { expect(subject.champion_rotations.max_new_player_level).to be_a Integer }
  end
end
