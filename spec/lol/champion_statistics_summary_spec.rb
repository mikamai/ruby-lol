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
    it_behaves_like 'plain attribute' do
      let(:attribute) { 'stats' }
      let(:attribute_value) { 'asd' }
    end

    context 'when is passed as an hash' do
      subject { ChampionStatisticsSummary.new stats: { 'FooBar' => 'baz' } }

      it 'will convert the hash in an openstruct object' do
        expect(subject.stats).to be_a OpenStruct
      end

      it 'will convert each hash key in underscore' do
        expect(subject.stats.foo_bar).to eq 'baz'
      end
    end
  end
end
