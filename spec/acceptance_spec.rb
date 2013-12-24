require "spec_helper"
require "lol"
require "awesome_print"

# Requires connection
describe "Live API testing", :remote => true do
  before(:all) do
    VCR.configure do |c|
      c.allow_http_connections_when_no_cassette = true
    end
  end

  subject    { Lol::Client.new ENV['RIOT_GAMES_API_KEY'] }
  let(:na)   { Lol::Client.new ENV['RIOT_GAMES_API_KEY'], :region => "na" }
  let(:eune) { Lol::Client.new ENV['RIOT_GAMES_API_KEY'], :region => "eune" }
  let(:br)   { Lol::Client.new ENV['RIOT_GAMES_API_KEY'], :region => "br"}
  let(:tr)   { Lol::Client.new ENV['RIOT_GAMES_API_KEY'], :region => "tr"}

  describe "champion-v1.1" do
    context "working realms" do
      %w(euw na eune).each do |realm|
        it "works on #{realm}" do
          subject.region = realm
          expect { subject.champion.get }.not_to raise_error
        end
      end
    end
  end

  describe "game-v1.2" do
    context "working realms" do
      %w(euw na eune).each do |realm|
        it "works on #{realm}" do
          subject.region = realm
          expect { subject.game.recent(summoners[realm]) }.not_to raise_error
        end
      end
    end
  end

  after(:all) do
    VCR.configure do |c|
      c.allow_http_connections_when_no_cassette = true
    end
  end
end
