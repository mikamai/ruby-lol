require "spec_helper"
require "lol"

include Lol

describe MasteryPage do
  it_behaves_like 'Lol model' do
    let(:valid_attributes) { { id: 1 } }
  end

  %w(id name current).each do |attribute|
    it_behaves_like "plain attribute" do
      let(:attribute) { attribute }
      let(:attribute_value) { "asd" }
    end
  end

  describe "#masteries" do
    let(:fixture) { load_fixture("summoner-masteries", SummonerRequest.api_version, "get") }
    let(:masteries) { fixture["30743211"]["pages"].first["masteries"] }

    subject { MasteryPage.new fixture["30743211"]["pages"].first }

    it "is populated by talents" do
      expect(subject.masteries.size).to eq(masteries.size)
    end
  end

end
