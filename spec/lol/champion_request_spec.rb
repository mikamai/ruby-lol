require "spec_helper"
require "lol"

include Lol

describe ChampionRequest do
  subject { described_class.new("api_key", "euw") }
  before do
    allow(subject).to receive(:warn_for_deprecation).and_return nil
  end
  
  it "inherits from V3Request" do
    expect(described_class.ancestors[1]).to eq(V3Request)
  end

  describe "#find" do
    it "returns a champion" do
      stub_request subject, 'champion-266', 'champions/266'
      expect(subject.find 266).to be_a Champion
    end
  end

  describe "#all" do
    before { stub_request subject, 'champion-all', 'champions', 'freeToPlay' => false }
    let(:result) { subject.all }

    it "returns an array of champions" do
      expect(result).to be_a Array
      expect(result.map(&:class).uniq).to eq [Champion]
    end

    it "fetches champions from the API" do
      expect(result.size).to eq load_fixture('champion-all', described_class.api_version)['champions'].size
    end
  end

  describe "#get" do
    context "(champion_id: ...)" do
      it "calls ChampionRequest#find" do
        expect(subject).to receive(:find).with(123)
        subject.get id: 123
      end

      it "shows a deprecation warning" do
        stub_request subject, 'champion-266', 'champions/266'
        expect(subject).to receive :warn_for_deprecation
        subject.get id: 266
      end
    end

    context "(...)" do
      it "calls ChampionRequest#all" do
        expect(subject).to receive(:all).with(free_to_play: false)
        subject.get
      end

      it "shows a deprecation warning" do
        stub_request subject, 'champion-all', 'champions', 'freeToPlay' => true
        expect(subject).to receive :warn_for_deprecation
        subject.get free_to_play: true
      end
    end
  end
end
