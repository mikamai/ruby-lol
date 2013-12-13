require "spec_helper"
require "lol"

include Lol

describe Roster do
  it_behaves_like 'Lol model' do
    let(:valid_attributes) { { owner_id: 1 } }
  end

  describe "owner_id attribute" do
    it_behaves_like 'plain attribute' do
      let(:attribute) { 'owner_id' }
      let(:attribute_value) { 'asd' }
    end
  end

  describe 'member_list attribute' do
    it_behaves_like 'collection attribute' do
      let(:attribute) { 'member_list' }
      let(:attribute_class) { TeamMember }
    end
  end
end
