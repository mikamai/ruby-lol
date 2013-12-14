require "spec_helper"
require "lol"

include Lol

describe MiniSeries do
  it "inherits from Lol::Model" do
    expect(MiniSeries.ancestors[1]).to eq(Model)
  end

  context "initialization" do
    it_behaves_like 'Lol model' do
      let(:valid_attributes) { { target: 3 } }
    end

    %w(target wins losses time_left_to_play_millis progress).each do |attribute|
      describe "#{attribute} attribute" do
        it_behaves_like 'plain attribute' do
          let(:attribute) { attribute }
          let(:attribute_value) { 'asd' }
        end
      end
    end
  end
end
