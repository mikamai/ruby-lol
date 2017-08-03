# ruby-lol
[![Gem Version](https://badge.fury.io/rb/ruby-lol.png)](http://badge.fury.io/rb/ruby-lol) [![Coverage Status](https://coveralls.io/repos/mikamai/ruby-lol/badge.png)](https://coveralls.io/r/mikamai/ruby-lol) [![Build Status](https://travis-ci.org/mikamai/ruby-lol.png?branch=master)](https://travis-ci.org/mikamai/ruby-lol) [![Dependency Status](https://gemnasium.com/mikamai/ruby-lol.png)](https://gemnasium.com/mikamai/ruby-lol) [![Inline docs](http://inch-ci.org/github/mikamai/ruby-lol.png?branch=master)](http://inch-ci.org/github/mikamai/ruby-lol)


ruby-lol is a wrapper to the [Riot Games API](https://developer.riotgames.com).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-lol'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby-lol

## Usage

[ Outdated, anyone who wants to contribute to this please do it :) ]

```ruby
require 'lol'

client = Lol::Client.new "my_api_key", region: "euw"
# => <Lol::Client:0x000000020c0b28 @api_key="my_api_key", @region="euw", @cached=false>

# You can cache requests using Redis now
# ttl defaults to 900
client = Lol::Client.new "my_api_key", region: "euw", redis: "redis://localhost:6379", ttl: 900

# You can specify your rate limits so that the library will throttle requests to avoid errors
client = Lol::Client.new "new_api_key", region: "euw", rate_limit_requests: 1, rate_limit_seconds: 10

# Available Requests
client.champion
# => Lol::ChampionRequest
client.game
# => Lol::GameRequest
client.league
# => Lol::LeagueRequest
client.stats
# => Lol::StatsRequest
client.summoner
# => Lol::SummonerRequest
client.team
# => Lol::TeamRequest

# Available methods for each request type
client.champion.get
# => Lol::Champion

client.game.recent(summoner_id)
# => Lol::Game

client.league.get(summoner_id)
# => Lol::League

client.stats.summary(summoner_id)
# => Lol::SummaryStats
client.stats.ranked(summoner_id)
# => Lol::RankedStats

client.summoner.masteries(summoner_id)
# => [Lol::Masterypage]
client.summoner.runes(summoner_id)
# => [Lol::Runepage]
client.summoner.by_name(name)
# => Lol::Summoner
client.summoner.get(summoner_id)
# => Lol::Summoner
client.summoner.name(summoner_ids)
# => [Hash]

client.team.get(summoner_id)
# => Array
```

# Making Static Requests
The Riot API has a [section](http://developer.riotgames.com/api/methods#!/378) carved out for static-data. These requests don't count against your rate limit. The mechanism for using them is similar to the standard requests above.

Each static endpoint has two possible requests: `get` and `get(id)`. `get` returns an array of OpenStructs representing the data from Riot's API, and `get(id)` returns an OpenStruct with a single record. Here are some examples:

```ruby
client.static
# => Lol::StaticRequest
**NOTE**: StaticRequest is not meant to be used directly, but can be!

client.static.champion
# => Lol::StaticRequest (for endpoint /static-data/champion)

client.static.champion.get
# => [OpenStruct] (with keys from http://developer.riotgames.com/api/methods#!/378/1349)

client.static.champion.get(id)
# => OpenStruct (with keys from http://developer.riotgames.com/api/methods#!/378/1349)
```

You can also pass query parameters as listed in the Riot API documentation. For example:

```ruby

# returns all attributes
client.static.champion.get(champData: 'all')

# returns only lore information
client.static.champion.get(champData: 'lore')
```

**NOTE**: The realm endpoint is not implemented. Let us know if you need it, but it seemed somewhat unnecessary.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Changelog
 - 0.9.14 Fixed a caching bug
 - 0.9.13 Updated to latest API versions
 - 0.9.12 Fixed a caching bug
 - 0.9.11 Added caching support via REDIS
 - 0.9.7 Updated LeagueRequest to API v2.3
 - 0.9.6 Updated SummonerRequest and GameRequest to API v1.3
 - 0.9.5 Fixed documentation
 - 0.9.4 Completed support for updated API


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/mikamai/ruby-lol/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
