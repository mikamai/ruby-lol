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

  let(:api_key) { ENV['RIOT_GAMES_NEW_KEY'] }
  subject       { Lol::Client.new api_key }

  # @TODO: Maybe have aliases with singular / plural names so I can do subject.champions?
  let (:champions) { subject.champion.get }
  let (:intinig)   { subject.summoner.by_name("intinig").first }
  let (:team)      { subject.team.by_summoner(intinig.id).first }

  describe "champion" do
    it "works on the collection" do
      expect {champions}.not_to raise_error
    end

    it "works on the single champion" do
      expect {subject.champion.get(:id => champions.first.id)}.not_to raise_error
    end
  end

  describe "game" do
    it "works on recent games for a summoner" do
      expect {subject.game.recent intinig.id}.not_to raise_error
    end
  end

  describe "league" do
    it "works with get" do
      expect {subject.league.get intinig.id}.not_to raise_error
    end

    it "works with entries" do
      expect {subject.league.get_entries intinig.id}.not_to raise_error
    end

    it "works with teams" do
      expect {subject.league.by_team team.id}.not_to raise_error
    end
  end

  describe "lol-static-data" do
    pending
  end

  describe "match" do
    pending
  end

  describe "matchhistory" do
    pending
  end

  describe "stats" do
    pending
  end

  describe "summoner" do
    pending
  end

  describe "team" do
    pending
  end

  after(:all) do
    VCR.configure do |c|
      c.allow_http_connections_when_no_cassette = true
    end
  end
end
