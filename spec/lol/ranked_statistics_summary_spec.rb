require "spec_helper"
require "lol"

include Lol

describe RankedStatisticsSummary do
  it_behaves_like 'Lol model' do
    let(:valid_attributes) { { summoner_id: 1 } }
  end

  %w(summoner_id modify_date_str).each do |attribute|
    describe "#{attribute} attribute" do
      it_behaves_like 'plain attribute' do
        let(:attribute) { attribute }
        let(:attribute_value) { 'asd' }
      end
    end
  end

  describe 'champions attribute' do
    it_behaves_like 'collection attribute' do
      let(:attribute) { 'champions' }
      let(:attribute_class) { ChampionStatisticsSummary }
    end
  end

  describe 'modify_date attribute' do
    it_behaves_like 'time attribute' do
      let(:attribute) { 'modify_date' }
    end
  end
end
