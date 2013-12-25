require "spec_helper"
require "lol"

include Lol

describe LeagueEntry do
  it "inherits from Lol::Model" do
    expect(League.ancestors[1]).to eq(Model)
  end

  context "initialization" do
    it_behaves_like 'Lol model' do
      let(:valid_attributes) { { player_or_team_id: 123456 } }
    end

    %w(player_or_team_id player_or_team_name league_name queue_type tier rank league_points wins is_hot_streak is_veteran is_fresh_blood is_inactive last_played time_until_decay).each do |attribute|
      describe "#{attribute} attribute" do
        it_behaves_like 'plain attribute' do
          let(:attribute) { attribute }
          let(:attribute_value) { 'asd' }
        end
      end
    end

    it "returns a MiniSeries object if a miniseries is available" do
      mini_series =<<-EOF
    {
      "playerOrTeamId" : "30247742",
      "playerOrTeamName" : "Danterno",
      "leagueName" : "Annie's Blades",
      "queueType" : "RANKED_SOLO_5x5",
      "tier" : "SILVER",
      "rank" : "II",
      "leaguePoints" : 84,
      "wins" : 35,
      "isHotStreak" : false,
      "isVeteran" : false,
      "isFreshBlood" : false,
      "isInactive" : false,
      "lastPlayed" : 0,
      "timeUntilDecay" : -1,
      "miniSeries" : {
        "target" : 2,
        "wins" : 0,
        "losses" : 1,
        "timeLeftToPlayMillis" : 0,
        "progress" : "LNN"
      }
    }
      EOF
      subject = LeagueEntry.new JSON.parse(mini_series)
      expect(subject.mini_series).to be_a(MiniSeries)
    end
  end
end
