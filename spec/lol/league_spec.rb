require "spec_helper"
require "lol"

include Lol

describe League do
  it "inherits from Lol::Model" do
    expect(League.ancestors[1]).to eq(Model)
  end

  context "initialization" do
    it_behaves_like 'Lol model' do
      let(:valid_attributes) { { timestamp: 123456 } }
    end

    %w(timestamp name tier queue).each do |attribute|
      describe "#{attribute} attribute" do
        it_behaves_like 'plain attribute' do
          let(:attribute) { attribute }
          let(:attribute_value) { 'asd' }
        end
      end
    end

    pending "fills entries with LeagueEntry objects"
  end
end
