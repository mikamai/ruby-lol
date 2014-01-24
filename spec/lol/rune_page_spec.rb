require "spec_helper"
require "lol"

include Lol

describe RunePage do
  it_behaves_like 'Lol model' do
    let(:valid_attributes) { { id: 1 } }
  end

  %w(id name current).each do |attribute|
    it_behaves_like "plain attribute" do
      let(:attribute) { attribute }
      let(:attribute_value) { "asd" }
    end
  end

  describe "#slots" do
    let(:fixture) { load_fixture("summoner-runes", "v1.3", "get") }
    let(:slots) { fixture["30743211"]["pages"].first["slots"] }

    subject { RunePage.new fixture["30743211"]["pages"].first }

    it "is populated by all slots" do
      expect(subject.slots.size).to eq(slots.size)
    end
  end
end
