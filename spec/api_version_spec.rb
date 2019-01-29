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
  check_api_version(ChampionRequest, "v3")
  check_api_version(ChampionMasteryRequest, "v4")
  check_api_version(LeagueRequest, "v4")
  check_api_version(StaticRequest, "v4")
  check_api_version(LolStatusRequest, "v3")
  check_api_version(MatchRequest, "v4")
  check_api_version(SummonerRequest, "v4")
  check_api_version(RunesRequest, "v4")
  check_api_version(MasteriesRequest, "v4")
  check_api_version(SpectatorRequest, "v4")
end
