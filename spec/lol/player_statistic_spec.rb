require "spec_helper"
require "lol"

include Lol

describe PlayerStatistic do
  it_behaves_like 'Lol model' do
    let(:valid_attributes) { { wins: 1 } }
  end

  %w(losses modify_date_str player_stat_summary_type wins).each do |attribute|
    describe "#{attribute} attribute" do
      it_behaves_like 'plain attribute' do
        let(:attribute) { attribute }
        let(:attribute_value) { 'asd' }
      end
    end
  end

  describe 'aggregated_stats attribute' do
    it_behaves_like 'collection attribute' do
      let(:attribute) { 'aggregated_stats' }
      let(:attribute_class) { AggregatedStatistic }
    end
  end

  describe 'modify_date attribute' do
    it_behaves_like 'time attribute' do
      let(:attribute) { 'modify_date' }
    end
  end
end
