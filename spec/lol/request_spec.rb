require "spec_helper"
require "lol"

include Lol

describe Request do
  context "initialization" do
    it "requires an api_key parameter" do
      expect { ChampionRequest.new }.to raise_error(ArgumentError)
    end

    it "accepts a region parameter" do
      expect { ChampionRequest.new "foo" }.to raise_error(ArgumentError)
    end

    it "correctly sets api key" do
      expect(ChampionRequest.new("api_key", "euw").api_key).to eq("api_key")
    end

    it "sets the cache store" do
      redis_store = Redis.new
      c = ChampionRequest.new("api_key", "euw", redis_store)
      expect(c.cache_store).to eq(redis_store)
    end

    it "returns an error if the cache store is not supported" do
      expect { ChampionRequest.new "api_key", "euw", {cached: true, redis: "FOO"}}.to raise_error(InvalidCacheStore)
    end
  end

  subject { Request.new "api_key", "euw"}

  describe "#perform_request" do

    let(:error401) { error_401 }
    let(:error429) { error_429 }

    it "calls HTTParty get" do
      expect(subject.class).to receive(:get).and_return(error401)
      expect { subject.perform_request "foo?api_key=asd"}.to raise_error(InvalidAPIResponse)
    end

    it "handles 401" do
      expect(subject.class).to receive(:get).and_return(error401)
      expect { subject.perform_request "foo?api_key=asd" }.to raise_error(InvalidAPIResponse)
    end

    it "handles 404" do
      expect(error401).to receive(:respond_to?).at_least(:once).and_return(true)
      expect(error401).to receive(:not_found?).and_return(true)
      expect(subject.class).to receive(:get).and_return(error401)
      expect { subject.perform_request "foo?api_key=asd"}.to raise_error(NotFound)
    end

    it 'handles 429' do
      expect(error429).to receive(:respond_to?).and_return(true)
      expect(subject.class).to receive(:get).and_return(error429)
      expect { subject.perform_request "foo?api_key=asd"}.to raise_error(TooManyRequests)
    end

    context "post requests" do
      it "supports post" do
        expect(subject.class).to receive(:post).and_return(true)
        expect { subject.perform_request "http://foo.com", :post }.not_to raise_error
      end
    end

    context "caching" do
      before :all do
        class FakeRedis < Redis
          attr_reader :store

          def initialize options = {}
            @store = {}
          end

          def get key
            @store[key]
          end

          def setex key, ttl, val
            @store[key] = val
            @store["#{key}:ttl"] = ttl
          end
        end
      end

      let(:fake_redis) { FakeRedis.new }
      let(:request) { Request.new "api_key", "euw", {redis: fake_redis, ttl: 60, cached: true }}
      before :each do
        expect(request.class).to receive(:get).with("/foo?api_key=asd").and_return({foo: "bar"}).at_least(:once)
        first_result = request.perform_request "/foo?api_key=asd"
      end

      it "is cached" do
        expect(request.class).not_to receive(:get)
        request.perform_request "/foo?api_key=asd"
      end

      it "is not cached if post" do
        expect(request.class).to receive(:post).twice
        request.perform_request "/foo?api_key=asd", :post
        request.perform_request "/foo?api_key=asd", :post
      end

      it "serializes cached responses" do
        expect(JSON).to receive(:parse)
        request.perform_request "/foo?api_key=asd"
      end

      it "sets ttl" do
        expect(fake_redis.get("/foo?{}:ttl")).to eq(60)
      end

      it "uses clean urls" do
        expect(request).to receive(:clean_url).at_least(:once)
        request.perform_request "/foo?api_key=asd"
      end
    end
  end

  describe "clean_url" do
    it "works when url does not have a query string" do
      expect { subject.clean_url 'http://www.leagueoflegends.com' }.not_to raise_error
    end
  end

  describe "api_url" do
    it "defaults on Request#region" do
      expect(subject.api_url("bar")).to match(/\/euw\//)
    end

    it "defaults on Reques.api_version" do
      expect(subject.api_url("bar")).to match(/\/v1.1\//)
    end

    it "a path" do
      expect { subject.api_url }.to raise_error(ArgumentError)
    end

    it "returns a full fledged api url" do
      expect(subject.api_url("bar")).to eq("https://euw.api.pvp.net/api/lol/euw/v1.1/bar?api_key=api_key")
    end

    it "optionally accept query string parameters" do
      expect(subject.api_url("foo", a: 'b')).to eq("https://euw.api.pvp.net/api/lol/euw/v1.1/foo?a=b&api_key=api_key")
    end

    it "delegates the base url to #api_base_url" do
      allow(subject).to receive(:api_base_url).and_return 'foo'
      expect(subject.api_url 'bar').to match /^foo/
    end

    it "delegates the query string to #api_query_string" do
      allow(subject).to receive(:api_query_string).and_return 'foo'
      expect(subject.api_url 'bar').to match /\?foo$/
    end
  end

  describe "post_api_url" do
    let(:pau) { subject.post_api_url "/foo" }

    it "returns an hash" do
      expect(pau).to be_a(Hash)
    end

    it "contains an url key" do
      expect(pau).to have_key(:url)
    end

    it "contains an options key" do
      expect(pau).to have_key(:options)
    end

    it "contains a header key in options" do
      expect(pau[:options]).to have_key(:headers)
    end

    it "returns the api key in an header" do
      expect(pau[:options][:headers]).to have_key("X-Riot-Token")
      expect(pau[:options][:headers]["X-Riot-Token"]).to eq(subject.api_key)
    end

    it "includes a content-type header" do
      expect(pau[:options][:headers]["Content-Type"]).to eq("application/json")
    end

    it "uses api_url for the url part" do
      expect(pau[:url]).to eq(subject.api_url "/foo")
    end
  end

  describe "#api_base_url" do
    it "returns the base domain" do
      expect(subject.api_base_url).to eq "https://euw.api.pvp.net"
    end
  end

  describe "#api_query_string" do
    it "returns the api key as query string" do
      expect(subject.api_query_string).to eq "api_key=api_key"
    end

    it "optionally accept other params" do
      expect(subject.api_query_string foo: 'bar').to eq "foo=bar&api_key=api_key"
    end
  end
end
