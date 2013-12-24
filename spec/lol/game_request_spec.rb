require "spec_helper"
require "lol"

include Lol

describe GameRequest do
  it "inherits from Request" do
    expect(GameRequest.ancestors[1]).to eq(Request)
  end

  describe "#recent" do
    let(:request) { GameRequest.new "api_key", "euw" }

    subject do
      expect(request.class).to receive(:get).with(request.api_url('v1.2', "game/by-summoner/1/recent")).and_return load_fixture('game', 'v1.2', 'get')

      request.recent 1
    end

    it 'returns an array' do
      expect(subject).to be_a Array
    end

    it 'returns an array of Games' do
      expect(subject.map(&:class).uniq).to eq [Game]
    end

    it 'fetches games from the API' do
      expect(subject.size).to eq load_fixture('game', 'v1.1', 'get')['games'].size
    end
  end

end
