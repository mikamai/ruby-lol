require "spec_helper"
require "lol"

include Lol


def check_api_version(klass, version)
  describe klass do
    it "should use API version #{version}" do
      expect(klass.api_version).to eq(version)
    end
  end
end

describe "API Versions" do
  check_api_version(ChampionRequest, "v1.1")
  check_api_version(GameRequest, "v1.3")
  check_api_version(LeagueRequest, "v2.2")
  check_api_version(StatsRequest, "v1.2")
  check_api_version(SummonerRequest, "v1.3")
  check_api_version(TeamRequest, "v2.2")
end
