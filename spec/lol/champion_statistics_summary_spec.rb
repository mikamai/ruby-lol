require "spec_helper"
require "lol"

include Lol

describe ChampionStatisticsSummary do
  it_behaves_like 'Lol model' do
    let(:valid_attributes) { { id: 1 } }
  end

  %w(id name).each do |attribute|
    describe "#{attribute} attribute" do
      it_behaves_like 'plain attribute' do
        let(:attribute) { attribute }
        let(:attribute_value) { 'asd' }
      end
    end
  end

  describe 'stats attribute' do
    it_behaves_like 'collection attribute' do
      let(:attribute) { 'stats' }
      let(:attribute_class) { ChampionStatistic }
    end
  end
end
