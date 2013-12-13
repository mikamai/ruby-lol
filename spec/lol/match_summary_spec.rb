require "spec_helper"
require "lol"

include Lol

describe MatchSummary do
  it_behaves_like 'Lol model' do
    let(:valid_attributes) { { win: true } }
  end

  %w(assists deaths game_id game_mode invalid kills map_id opposing_team_kills opposing_team_name win).each do |attribute|
    describe "#{attribute} attribute" do
      it_behaves_like 'plain attribute' do
        let(:attribute) { attribute }
        let(:attribute_value) { 'asd' }
      end
    end
  end

  describe "date attribute" do
    it_behaves_like 'time attribute' do
      let(:attribute) { 'date' }
    end
  end
end
