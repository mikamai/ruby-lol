require "lol"
require "spec_helper"

include Lol

describe Player do
  it_behaves_like 'Lol model' do
    let(:valid_attributes) { { team_id: 1 } }
  end

  %w(champion_id summoner_id team_id).each do |attribute|
    describe "#{attribute} attribute" do
      it_behaves_like 'plain attribute' do
        let(:attribute) { attribute }
        let(:attribute_value) { 'asd' }
      end
    end
  end
end
