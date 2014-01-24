require "spec_helper"
require "lol"

include Lol

describe MasteryPage do
  it_behaves_like 'Lol model' do
    let(:valid_attributes) { { id: 1 } }
  end

  %w(summoner_id name current).each do |attribute|
    it_behaves_like "plain attribute" do
      let(:attribute) { attribute }
      let(:attribute_value) { "asd" }
    end
  end

  describe "#talents" do
    let(:fixture) { load_fixture("summoner-masteries", "v1.3", "get") }
    let(:talents) { fixture["30743211"]["pages"].first["talents"] }

    subject { MasteryPage.new fixture["30743211"]["pages"].first }

    it "is populated by talents" do
      expect(subject.talents.size).to eq(talents.size)
    end
  end

end
