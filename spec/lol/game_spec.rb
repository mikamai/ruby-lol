require "spec_helper"
require "lol"

include Lol

describe Game do
  it_behaves_like 'Lol model' do
    let(:valid_attributes) { { game_id: 1 } }
  end

  %w(champion_id create_date_str game_id game_mode game_type invalid level map_id spell1 spell2 sub_type team_id).each do |attribute|
    describe "#{attribute} attribute" do
      it_behaves_like 'plain attribute' do
        let(:attribute) { attribute }
        let(:attribute_value) { 'asd' }
      end
    end
  end

  describe 'fellow_players attribute' do
    it_behaves_like 'collection attribute' do
      let(:attribute) { 'fellow_players' }
      let(:attribute_class) { Player }
    end
  end

  describe 'statistics attribute' do
    it_behaves_like 'collection attribute' do
      let(:attribute) { 'statistics' }
      let(:attribute_class) { RawStatistic }
    end
  end

  describe 'create_date attribute' do
    it_behaves_like 'plain attribute' do
      let(:attribute) { 'create_date' }
      let(:attribute_value) { Time.now }
    end

    it "does not parse the value is it isn't a Numeric value" do
      expect(Game.new(:create_date => Date.today).create_date).to be_a Date
    end

    it "works with LoL format" do
      expect(Game.new(:create_date => 1386804971247).create_date.year).to eq 2013
    end
  end
end
