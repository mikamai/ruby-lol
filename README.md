# ruby-lol
[![Gem Version](https://badge.fury.io/rb/ruby-lol.png)](http://badge.fury.io/rb/ruby-lol) [![Coverage Status](https://coveralls.io/repos/mikamai/ruby-lol/badge.png)](https://coveralls.io/r/mikamai/ruby-lol) [![Build Status](https://travis-ci.org/mikamai/ruby-lol.png?branch=master)](https://travis-ci.org/mikamai/ruby-lol) [![Code Climate](https://codeclimate.com/repos/52a9908c56b102320a0166a4/badges/7e5d4ea4fe9e562f8e4d/gpa.png)](https://codeclimate.com/repos/52a9908c56b102320a0166a4/feed)[![Dependency Status](https://gemnasium.com/mikamai/ruby-lol.png)](https://gemnasium.com/mikamai/ruby-lol)


ruby-lol is a wrapper to the [Riot Games API](https://developer.riotgames.com).

## NEWS

Riot recently release a new version of the API. The old API calls will be available for the next six months. We are in the process of migrating all the API calls to the new versions.

You can safely use the library, it will still work for the next six months, but we plan to complete the migration before 2014 ;)

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

```ruby
    require 'lol'

    # defaults to euw
    client = Lol::Client.new "my_api_key"
    # => <Lol::Client:0x007fd09d1abb00 @api_key="my_api_key", @region="euw">

    # na
    na_client = Lol::Client.new "my_api_key", :region => "na"
    # => <Lol::Client:0x007fd09d1abb00 @api_key="my_api_key", @region="na">

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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
