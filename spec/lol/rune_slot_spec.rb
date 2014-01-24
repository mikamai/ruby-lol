require "spec_helper"
require "lol"

include Lol

describe RuneSlot do
  it_behaves_like 'Lol model' do
    let(:valid_attributes) { { id: 1 } }
  end

  it_behaves_like "plain attribute" do
    let(:attribute) { "id" }
    let(:attribute_value) { "asd" }
  end

  describe "#rune" do
    let(:fixture) { load_fixture("summoner-runes", "v1.3", "get") }
    let(:rune) { fixture["30743211"]["pages"].first["slots"].first["rune"] }

    subject { RuneSlot.new fixture["30743211"]["pages"].first["slots"].first }

    it "is a Rune object" do
      expect(subject.rune).to be_a(Rune)
    end
  end
end
