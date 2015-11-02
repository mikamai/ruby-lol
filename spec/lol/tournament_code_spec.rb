require "spec_helper"
require "lol"

include Lol

describe TournamentCode do
  it_behaves_like 'Lol model' do
    let(:valid_attributes) { { } }
  end

  %w(id provider_id tournament_id code region map
    team_size spectators pick_type lobby_name password).each do |attribute|
    describe "#{attribute} attribute" do
      it_behaves_like 'plain attribute' do
        let(:attribute) { attribute }
        let(:attribute_value) { 'asd' }
      end
    end
  end
end
