require 'spec_helper'
require 'lol'

describe Lol::FeaturedGamesRequest do
  subject { Lol::FeaturedGamesRequest.new 'api_key', 'euw' }

  it 'inherits from Lol::Request' do
    expect(subject.class.ancestors[1]).to eq Lol::Request
  end

  describe '#api_url' do
    it 'returns base_url joined with the given path and the api query string' do
      expect(subject.api_url 'foo').to eq "https://euw.api.pvp.net/observer-mode/rest/foo?api_key=api_key"
    end

    it 'delegates to api_base_url' do
      allow(subject).to receive(:api_base_url).and_return 'bar'
      expect(subject.api_url 'foo').to match /^bar\/observer-mode\/rest\/foo/
    end

    it 'delegates to api_query_string' do
      allow(subject).to receive(:api_query_string).with(a: 'a').and_return 'baz'
      expect(subject.api_url 'foo', a: 'a').to match /foo\?baz$/
    end
  end

  describe '#get' do
    it 'returns a dynamic model' do
      stub_request subject, 'featured-games', 'featured'
      expect(subject.get).to be_a Lol::DynamicModel
    end

    it 'gives the response to DynamicModel' do
      allow(subject).to receive(:perform_request).with(instance_of(String)).and_return 'a'
      expect(Lol::DynamicModel).to receive(:new).with('a').and_return 'foo'
      subject.get
    end
  end
end
