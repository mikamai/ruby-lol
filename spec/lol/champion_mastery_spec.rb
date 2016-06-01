require "spec_helper"
require "lol"

include Lol

describe ChampionMastery do
  it_behaves_like 'Lol model' do
    let(:valid_attributes) { { champion_id: 1 } }
  end

  %w(champion_id champion_level champion_points champion_points_since_last_level champion_points_until_next_level
                 chest_granted highest_grade last_play_time player_id tokens_earned).each do |attribute|
    describe "#{attribute} attribute" do
      it_behaves_like 'plain attribute' do
        let(:attribute) { attribute }
        let(:attribute_value) { 'asd' }
      end
    end
  end
end
