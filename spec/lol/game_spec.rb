require "spec_helper"
require "lol"

include Lol

describe Game do
  it_behaves_like 'Lol model' do
    let(:valid_attributes) { { game_id: 1 } }
  end

  %w(champion_id game_id game_mode game_type invalid level map_id spell1 spell2 sub_type team_id).each do |attribute|
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

  describe 'stats attribute' do
    it_behaves_like 'plain attribute' do
      let(:attribute) { 'stats' }
      let(:attribute_value) { 'asd' }
    end

    context 'when it is passed as an hash' do
      subject { Game.new stats: { 'FooBar' => 'baz' } }

      it 'will convert the hash in an openstruct object' do
        expect(subject.stats).to be_a OpenStruct
      end

      it 'will convert each hash key in underscore' do
        expect(subject.stats.foo_bar).to eq 'baz'
      end
    end
  end

  describe 'create_date attribute' do
    it_behaves_like 'time attribute' do
      let(:attribute) { 'create_date' }
    end
  end
end
