require "lol"
require "spec_helper"

include Lol

describe Champion do
  it_behaves_like 'Lol model' do
    let(:valid_attributes) { { id: 1 } }
  end

  %w(id name active attack_rank defense_rank magic_rank difficulty_rank bot_enabled free_to_play bot_mm_enabled ranked_play_enabled).each do |attribute|
    describe "#{attribute} attribute" do
      it_behaves_like 'plain attribute' do
        let(:attribute) { attribute }
        let(:attribute_value) { 'asd' }
      end
    end
  end
end
