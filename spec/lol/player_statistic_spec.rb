require "spec_helper"
require "lol"

include Lol

describe PlayerStatistic do
  it_behaves_like 'Lol model' do
    let(:valid_attributes) { { wins: 1 } }
  end

  %w(aggregated_stats losses modify_date_str player_stat_summary_type wins).each do |attribute|
    describe "#{attribute} attribute" do
      it_behaves_like 'plain attribute' do
        let(:attribute) { attribute }
        let(:attribute_value) { 'asd' }
      end
    end
  end

  describe 'aggregated_stats attribute' do
    it_behaves_like 'plain attribute' do
      let(:attribute) { 'aggregated_stats' }
      let(:attribute_value) { 'asd' }
    end

    context 'when is passed as an hash' do
      subject { PlayerStatistic.new aggregated_stats: { 'FooBar' => 'baz' } }

      it 'will convert the hash in an openstruct object' do
        expect(subject.aggregated_stats).to be_a OpenStruct
      end

      it 'will convert each hash key in underscore' do
        expect(subject.aggregated_stats.foo_bar).to eq 'baz'
      end
    end
  end

  describe 'modify_date attribute' do
    it_behaves_like 'time attribute' do
      let(:attribute) { 'modify_date' }
    end
  end
end
