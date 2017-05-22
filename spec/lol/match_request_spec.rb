require "spec_helper"
require "lol"

include Lol

describe MatchRequest do
  subject { MatchRequest.new "api_key", "euw" }

  it "inherits from Request" do
    expect(MatchRequest).to be < Request
  end

  describe "#find" do
    context "without a tournament code" do
      let(:result) { subject.find 1 }
      before { stub_request subject, 'match', "matches/1" }

      it "returns a DynamicModel" do
        expect(result).to be_a DynamicModel
      end
    end

    context "with a tournament code" do
      let(:result) { subject.find 1, tournament_code: 2 }
      before { stub_request subject, 'match-with-tc', "matches/1/by-tournament-code/2" }

      it "returns a DynamicModel" do
        expect(result).to be_a DynamicModel
      end
    end
  end

  describe "#find_timeline" do
    it "returns a DynamicModel" do
      stub_request subject, 'timeline', "timelines/by-match/1"
      expect(subject.find_timeline 1).to be_a DynamicModel
    end
  end

  describe "#ids_by_tournament_code" do
    it "returns a list of ids" do
      stub_request subject, 'ids-by-tc', "matches/by-tournament-code/1/ids"
      result = subject.ids_by_tournament_code '1'
      expect(result).to be_a Array
      expect(result.map(&:class).uniq).to eq [Integer]
    end
  end

  describe "#all" do
    it "returns a DynamicModel" do
      stub_request subject, 'matches', "matchlists/by-account/1"
      expect(subject.all account_id: 1).to be_a DynamicModel
    end
  end

  describe "#recent" do
    it "returns a DynamicModel" do
      stub_request subject, 'matches-recent', "matchlists/by-account/1/recent"
      expect(subject.recent account_id: 1).to be_a DynamicModel
    end
  end
end
