require "spec_helper"
require "lol"

include Lol

describe TeamRequest do
  let(:request) { TeamRequest.new "api_key", "euw" }

  it "inherits from Request" do
    expect(TeamRequest.ancestors[1]).to eq(Request)
  end

  describe "get" do
    let(:request) { TeamRequest.new "api_key", "euw" }
    let(:fixture) { load_fixture 'team', 'v2.1', 'get' }

    subject do
      expect(request.class).to receive(:get).with(request.api_url('v2.1', "team/by-summoner/1")).and_return fixture
      request.get 1
    end

    it 'requires a summoner' do
      expect { request.get }.to raise_error ArgumentError
    end

    it 'returns an array' do
      expect(subject).to be_a Array
    end

    it 'returns an array of Team' do
      expect(subject.map(&:class).uniq).to eq [Team]
    end

    it 'fetches Team from the API' do
      expect(subject.size).to eq fixture.size
    end
  end

end
