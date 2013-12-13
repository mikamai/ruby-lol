require "spec_helper"
require "lol"

include Lol

describe TeamMember do
  it_behaves_like 'Lol model' do
    let(:valid_attributes) { { player_id: 1 } }
  end

  %w(player_id status).each do |attribute|
    describe "#{attribute} attribute" do
      it_behaves_like 'plain attribute' do
        let(:attribute) { attribute }
        let(:attribute_value) { 'asd' }
      end
    end
  end

  %w(invite_date join_date).each do |attribute|
    describe "#{attribute} attribute" do
      it_behaves_like 'time attribute' do
        let(:attribute) { attribute }
      end
    end
  end
end
