require "spec_helper"
require "lol"

include Lol

describe League do
  it "inherits from Lol::Model" do
    expect(League.ancestors[1]).to eq(Model)
  end

  context "initialization" do
    it_behaves_like 'Lol model' do
      let(:valid_attributes) { { name: 'foo' } }
    end

    %w(name tier queue participant_id).each do |attribute|
      describe "#{attribute} attribute" do
        it_behaves_like 'plain attribute' do
          let(:attribute) { attribute }
          let(:attribute_value) { 'asd' }
        end
      end
    end

    it "fills entries with LeagueEntry objects" do
      league_data = load_fixture("league", LeagueRequest.api_version, "get")
      league = League.new(league_data[league_data.keys.first].first)
      expect(league.entries.map(&:class).uniq).to eq([LeagueEntry])
    end
  end
end
