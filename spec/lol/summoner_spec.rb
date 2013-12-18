require "spec_helper"
require "lol"

include Lol

describe Summoner do
  it_behaves_like 'Lol model' do
    let(:valid_attributes) { { id: 1 } }
  end

  %w(id name profile_icon_id revision_date revision_date_str summoner_level).each do |attribute|
    describe "#{attribute} attribute" do
      it_behaves_like 'plain attribute' do
        let(:attribute) { attribute }
        let(:attribute_value) { 'asd' }
      end
    end
  end

end
