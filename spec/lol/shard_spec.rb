require "lol"
require "spec_helper"

include Lol

describe Shard, focus: true do
  %w(hostname name region_tag slug locales).each do |attribute|
    describe "#{attribute} attribute" do
      it_behaves_like 'plain attribute' do
        let(:attribute) { attribute }
        let(:attribute_value) { 'asd' }
      end
    end
  end
end
