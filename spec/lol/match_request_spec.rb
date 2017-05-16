require "spec_helper"
require "lol"

include Lol

describe MatchRequest do
  subject { MatchRequest.new "api_key", "euw" }
  before { allow(subject).to receive(:warn_for_deprecation) }

  it "inherits from V3Request" do
    expect(MatchRequest).to be < V3Request
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

  describe "#get" do
    it 'returns an hash' do
      stub_request subject, 'match', "matches/1"
      expect(subject.get 1).to be_a Hash
    end

    it 'calls #find' do
      expect(subject).to receive(:find).with 1
      subject.get 1
    end

    it 'shows a deprecation warning' do
      stub_request subject, 'match', "matches/1"
      expect(subject).to receive(:warn_for_deprecation)
      subject.get 1
    end
  end

  describe '#by_tournament' do
    it 'returns an Array' do
      stub_request subject, 'ids-by-tc', "matches/by-tournament-code/1/ids"
      expect(subject.by_tournament 1).to be_a(Array)
    end

    it 'calls #ids_by_tournament_code' do
      expect(subject).to receive(:ids_by_tournament_code).with 1
      subject.by_tournament 1
    end

    it 'shows a deprecation warning' do
      stub_request subject, 'ids-by-tc', "matches/by-tournament-code/1/ids"
      expect(subject).to receive(:warn_for_deprecation)
      subject.by_tournament 1
    end
  end

  describe '#for_tournament' do
    it 'returns an hash' do
      stub_request subject, 'match-with-tc', "matches/1/by-tournament-code/2"
      expect(subject.for_tournament 1, '2').to be_a(Hash)
    end

    it 'calls #find' do
      expect(subject).to receive(:find).with 1, tournament_code: '2'
      subject.for_tournament 1, '2'
    end

    it 'shows a deprecation warning' do
      stub_request subject, 'match-with-tc', "matches/1/by-tournament-code/2"
      expect(subject).to receive(:warn_for_deprecation)
      subject.for_tournament 1, '2'
    end
  end
end
