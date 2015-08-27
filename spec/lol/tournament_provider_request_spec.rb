require "spec_helper"
require "lol"

include Lol

describe TournamentProviderRequest do
  it "inherits from Request" do
    expect(TournamentProviderRequest.ancestors[1]).to eq(Request)
  end

  let(:request) { TournamentProviderRequest.new("api_key", "euw") }

  describe "#api_url" do
    subject { request.api_url "foo/bar"}

    it "matches the tournament api paths" do
      expect(subject).to eq("https://global.api.pvp.net/tournament/public/#{TournamentProviderRequest.api_version}/foo/bar")
    end
  end

  describe "#provider" do
    subject { request.provider("EUW", "https://foo.com") }

    # before(:each) { stub_request(request, 'tournament', "tournament/public/#/recent") }

    # it 'returns an array' do
    #   expect(subject).to be_a(Array)
    # end
    #
    # it 'returns an array of Games' do
    #   expect(subject.map(&:class).uniq).to eq([Game])
    # end
    #
    # it 'fetches games from the API' do
    #   fixture = load_fixture('game', GameRequest.api_version)
    #   expect(subject.size).to eq(fixture['games'].size)
    # end
  end

end
