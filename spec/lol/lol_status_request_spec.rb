require "spec_helper"
require "lol"

include Lol

describe LolStatusRequest do
  it 'inherits from Request' do
    expect(LolStatusRequest.ancestors[1]).to eq(Request)
  end

  describe '#api_url' do
    it 'returns full url for' do
      expect(subject.api_url('shards')).to eq 'http://status.leagueoflegends.com/shards'
    end

    it 'returns full url with path' do
      expect(subject.api_url('shards', 'something')).to eq 'http://status.leagueoflegends.com/shards/something'
    end
  end

  let(:request) { LolStatusRequest.new }

  describe "#shards" do
    subject { request.shards }

    before(:each) { stub_request(request, 'lol-status-shards', 'shards') }

    it 'returns an array' do
      expect(subject).to be_a(Array)
    end

    it 'returns an array of Shard' do
      expect(subject.map(&:class).uniq).to eq([Shard])
    end

    it 'fetches shards from the API' do
      fixture = load_fixture('lol-status-shards', LolStatusRequest.api_version)
      expect(subject.size).to eq(fixture.size)
    end
  end
end
