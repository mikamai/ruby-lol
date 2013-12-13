require "lol"
require "spec_helper"

include Lol

describe AggregatedStatistic do
  it_behaves_like 'Lol model' do
    let(:valid_attributes) { { id: 1 } }
  end

  %w(id name count).each do |attribute|
    describe "#{attribute} attribute" do
      it_behaves_like 'plain attribute' do
        let(:attribute) { attribute }
        let(:attribute_value) { 'asd' }
      end
    end
  end
end
