$LOAD_PATH.unshift(__dir__ + "/../lib")

require "rubygems"
require "ap"
require "lol"

include Lol

client = Client.new "18b7c486-0d5a-459f-9d60-cf8776b154c6"
intinig = client.summoner.by_name "intinig"
leagues = client.league.get intinig.id
my_league = leagues.first

my_league.entries.select {|entry| entry.player_or_team_name == "intinig"}.each do |entry|
  ap entry
end
