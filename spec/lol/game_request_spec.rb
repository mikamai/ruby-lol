require "spec_helper"
require "lol"

include Lol

describe GameRequest do
  it "inherits from Request" do
    expect(GameRequest.ancestors[1]).to eq(Request)
  end

  let(:request) { GameRequest.new("api_key", "euw") }

  describe "#recent" do
    subject { request.recent(1) }

    before(:each) { stub_request(request, 'game', 'game/by-summoner/1/recent') }

    it 'returns an array' do
      expect(subject).to be_a(Array)
    end

    it 'returns an array of Games' do
      expect(subject.map(&:class).uniq).to eq([Game])
    end

    it 'fetches games from the API' do
      fixture = load_fixture('game', GameRequest.api_version)
      expect(subject.size).to eq(fixture['games'].size)
    end
  end

end
