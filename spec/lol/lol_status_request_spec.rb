require "spec_helper"
require "lol"

include Lol

describe LolStatusRequest do
  subject { LolStatusRequest.new "api_key", "euw" }
  before { allow(subject).to receive(:warn_for_deprecation) }

  it 'inherits from V3Request' do
    expect(LolStatusRequest).to be < V3Request
  end

  describe '#shard_data' do
    let(:response) { subject.shard_data }

    before(:each) { stub_request(subject, 'lol-status-shard', 'shard-data') }

    it 'returns a Shard' do
      expect(response).to be_a(DynamicModel)
    end

    it 'services returns an array of Services' do
      expect(response.services.map(&:class).uniq).to eq([DynamicModel])
    end
  end

end
