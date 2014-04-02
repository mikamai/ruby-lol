require "spec_helper"
require "lol"

include Lol

describe RuneSlot do
  it_behaves_like 'Lol model' do
    let(:valid_attributes) { { id: 1 } }
  end

  it_behaves_like "plain attribute" do
    let(:attribute) { "id" }
    let(:attribute_value) { "asd" }
  end

end
