require "spec_helper"
require "lol"

include Lol

describe LeagueList do
  it "behaves like a DynamicModel" do
    expect(described_class).to be < DynamicModel
  end

  it "returns a list of LeagueEntry objects for the entries property" do
    subject = described_class.new items: [{}], entries: [{}]
    expect(subject.items.map(&:class)).to eq [LeagueList]
    expect(subject.entries.map(&:class)).to eq [LeagueEntry]
  end
end
