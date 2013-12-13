require "spec_helper"
require "lol"

include Lol

describe TeamStatistic do
  it_behaves_like 'Lol model' do
    let(:valid_attributes) { { losses: 1 } }
  end

  %w(average_games_played losses max_rating rating seed_rating team_stat_type wins).each do |attribute|
    describe "#{attribute} attribute" do
      it_behaves_like 'plain attribute' do
        let(:attribute) { attribute }
        let(:attribute_value) { 'asd' }
      end
    end
  end

  describe 'team_id attribute' do
    it_behaves_like 'plain attribute' do
      let(:attribute) { 'team_id' }
      let(:attribute_value) { 'asd' }
    end

    it 'parses the value if it is an Hash' do
      model = Team.new team_id: { 'fullId' => 1 }
      expect(model.team_id).to eq 1
    end
  end
end
