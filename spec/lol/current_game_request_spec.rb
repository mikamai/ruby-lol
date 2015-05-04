require 'spec_helper'
require 'lol'

describe Lol::CurrentGameRequest do
  subject { Lol::CurrentGameRequest.new 'api_key', 'euw' }

  it 'inherits from Lol::Request' do
    expect(subject.class.ancestors[1]).to eq Lol::Request
  end

  describe '#api_url' do
    it 'returns base_url joined with the given path and the api query string' do
      expect(subject.api_url 'foo').to eq "https://euw.api.pvp.net/observer-mode/rest/consumer/foo?api_key=api_key"
    end

    it 'delegates to api_base_url' do
      allow(subject).to receive(:api_base_url).and_return 'bar'
      expect(subject.api_url 'foo').to match /^bar\/observer-mode\/rest\/consumer\/foo/
    end

    it 'delegates to api_query_string' do
      allow(subject).to receive(:api_query_string).with(a: 'a').and_return 'baz'
      expect(subject.api_url 'foo', a: 'a').to match /foo\?baz$/
    end
  end

  describe '#spectator_game_info' do
    let(:expected_url) { 'getSpectatorGameInfo/EUW1/1' }

    it 'requires platform and summoner id' do
      expect {
        subject.spectator_game_info
      }.to raise_error ArgumentError, /\(0 for 2\)/
    end

    it 'returns a DynamicModel' do
      stub_request subject, 'current-game', expected_url
      expect(subject.spectator_game_info 'EUW1', '1').to be_a DynamicModel
    end

    it 'gives the response to DynamicModel' do
      allow(subject).to receive(:perform_request).with(instance_of(String)).and_return 'a'
      expect(Lol::DynamicModel).to receive(:new).with('a').and_return 'foo'
      subject.spectator_game_info 'EUW1', '1'
    end
  end
end
