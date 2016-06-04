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

## <a name="versions"></a>Supported API Versions

The following endpoints are supported.

| Endpoint            | Supported Version | Object                  |
|---------------------|-------------------|-------------------------|
| champion            | 1.2               | client.champion         |
| championmastery     | not versioned     | client.champion_mastery |
| current-game        | 1.0               | client.current_game     |
| featured-games      | 1.0               | client.featured_games   |
| game                | 1.3               | client.game             |
| league              | 2.5               | client.league           |
| lol-static-data     | 1.2               | client.static           |
| match               | 2.2               | client.match            |
| matchlist           | 2.2               | client.match_list       |
| stats               | 1.3               | client.stats            |
| summoner            | 1.4               | client.summoner         |
| team                | 2.4               | client.team             |
| tournament-provider | 1                 | client.tournament       |

## Usage

### Create a client

Create a client by passing in your API Key and region (defaults to 'euw').

```ruby
client = LoL::Client.new "my_key", region: 'na'
=> #<Lol::Client:0x007ffd218c57a0 @api_key="my_key", @region="na", @cached=false, @rate_limited=false>
```

Caching and rate limiting can optionally be enabled when creating a client

##### Caching

Caching via Redis is supported. To enable caching, pass the url of the redis server as the `:redis` option, and optionally include the `:ttl` option.
```ruby
Lol::Client.new "my key", region: 'na', redis: "redis://localhost:6379"
```

##### Rate Limiting

When creating a client, rate limiting can be enabled to automatically manage your rate limit, blocking requests until they can be performed.
For example, to enable rate limiting with a limit of 500 requests in 10 minutes
```ruby
Client.new "api key", region: 'na', rate_limit_requests: 500, rate_limit_seconds: 600
```

### Making requests

Each API has a request object, that is accessed from the client (see the [supported API versions](#versions) for a list)
```ruby
summoner_requests = client.summoner
=> #<Lol::SummonerRequest:0x007ffd218adf60 @cache_store={:redis=>nil, :ttl=>nil, :cached=>false}, @rate_limiter=nil, @api_key="my_key", @region="na">

```

Request objects have methods to access each endpoint in the API

```ruby
player = summoner_requests.by_name('rakalakalili')
=> [<Lol::Summoner: @id=496402, @name="rakalakalili", @profile_icon_id=561, @summoner_level=30, @revision_date=2016-05-31 23:21:40 -0600>]
summoner_requests.runes(player.id)
=> {"496402"=>[<Lol::RunePage: @id=1254232, @name="Thresh", @current=false, @slots=[<Lol::RuneSlot: @rune_slot_id=1, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=2, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=3, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=4, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=5, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=6, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=7, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=8, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=9, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=10, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=11, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=12, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=13, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=14, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=15, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=16, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=17, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=18, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=19, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=20, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=21, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=22, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=23, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=24, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=25, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=26, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=27, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=28, @rune_id=5347>, <Lol::RuneSlot: @rune_slot_id=29, @rune_id=5347>, <Lol::RuneSlot: @rune_slot_id=30, @rune_id=5347>]>, <Lol::RunePage: @id=1254233, @name="Nami", @current=false, @slots=[<Lol::RuneSlot: @rune_slot_id=1, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=2, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=3, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=4, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=5, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=6, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=7, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=8, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=9, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=10, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=11, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=12, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=13, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=14, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=15, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=16, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=17, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=18, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=19, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=20, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=21, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=22, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=23, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=24, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=25, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=26, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=27, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=28, @rune_id=5347>, <Lol::RuneSlot: @rune_slot_id=29, @rune_id=5347>, <Lol::RuneSlot: @rune_slot_id=30, @rune_id=5351>]>, <Lol::RunePage: @id=5935378, @name="Nid JG", @current=false, @slots=[<Lol::RuneSlot: @rune_slot_id=1, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=2, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=3, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=4, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=5, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=6, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=7, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=8, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=9, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=10, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=11, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=12, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=13, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=14, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=15, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=16, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=17, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=18, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=19, @rune_id=5296>, <Lol::RuneSlot: @rune_slot_id=20, @rune_id=5296>, <Lol::RuneSlot: @rune_slot_id=21, @rune_id=5296>, <Lol::RuneSlot: @rune_slot_id=22, @rune_id=5296>, <Lol::RuneSlot: @rune_slot_id=23, @rune_id=5296>, <Lol::RuneSlot: @rune_slot_id=24, @rune_id=5296>, <Lol::RuneSlot: @rune_slot_id=25, @rune_id=5296>, <Lol::RuneSlot: @rune_slot_id=26, @rune_id=5296>, <Lol::RuneSlot: @rune_slot_id=27, @rune_id=5296>, <Lol::RuneSlot: @rune_slot_id=28, @rune_id=5357>, <Lol::RuneSlot: @rune_slot_id=29, @rune_id=5357>, <Lol::RuneSlot: @rune_slot_id=30, @rune_id=5357>]>, <Lol::RunePage: @id=9904741, @name="AP/PEN", @current=false, @slots=[<Lol::RuneSlot: @rune_slot_id=1, @rune_id=5273>, <Lol::RuneSlot: @rune_slot_id=2, @rune_id=5273>, <Lol::RuneSlot: @rune_slot_id=3, @rune_id=5273>, <Lol::RuneSlot: @rune_slot_id=4, @rune_id=5273>, <Lol::RuneSlot: @rune_slot_id=5, @rune_id=5273>, <Lol::RuneSlot: @rune_slot_id=6, @rune_id=5273>, <Lol::RuneSlot: @rune_slot_id=7, @rune_id=5273>, <Lol::RuneSlot: @rune_slot_id=8, @rune_id=5273>, <Lol::RuneSlot: @rune_slot_id=9, @rune_id=5273>, <Lol::RuneSlot: @rune_slot_id=10, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=11, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=12, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=13, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=14, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=15, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=16, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=17, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=18, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=19, @rune_id=5295>, <Lol::RuneSlot: @rune_slot_id=20, @rune_id=5295>, <Lol::RuneSlot: @rune_slot_id=21, @rune_id=5295>, <Lol::RuneSlot: @rune_slot_id=22, @rune_id=5295>, <Lol::RuneSlot: @rune_slot_id=23, @rune_id=5295>, <Lol::RuneSlot: @rune_slot_id=24, @rune_id=5295>, <Lol::RuneSlot: @rune_slot_id=25, @rune_id=5297>, <Lol::RuneSlot: @rune_slot_id=26, @rune_id=5297>, <Lol::RuneSlot: @rune_slot_id=27, @rune_id=5297>, <Lol::RuneSlot: @rune_slot_id=28, @rune_id=5357>, <Lol::RuneSlot: @rune_slot_id=29, @rune_id=5357>, <Lol::RuneSlot: @rune_slot_id=30, @rune_id=5357>]>, <Lol::RunePage: @id=9904742, @name="spider", @current=false, @slots=[<Lol::RuneSlot: @rune_slot_id=1, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=2, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=3, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=4, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=5, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=6, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=7, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=8, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=9, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=10, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=11, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=12, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=13, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=14, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=15, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=16, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=17, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=18, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=19, @rune_id=5297>, <Lol::RuneSlot: @rune_slot_id=20, @rune_id=5297>, <Lol::RuneSlot: @rune_slot_id=21, @rune_id=5297>, <Lol::RuneSlot: @rune_slot_id=22, @rune_id=5297>, <Lol::RuneSlot: @rune_slot_id=23, @rune_id=5297>, <Lol::RuneSlot: @rune_slot_id=24, @rune_id=5297>, <Lol::RuneSlot: @rune_slot_id=25, @rune_id=5297>, <Lol::RuneSlot: @rune_slot_id=26, @rune_id=5297>, <Lol::RuneSlot: @rune_slot_id=27, @rune_id=5297>, <Lol::RuneSlot: @rune_slot_id=28, @rune_id=5347>, <Lol::RuneSlot: @rune_slot_id=29, @rune_id=5365>, <Lol::RuneSlot: @rune_slot_id=30, @rune_id=5365>]>, <Lol::RunePage: @id=9904743, @name="YAS", @current=false, @slots=[<Lol::RuneSlot: @rune_slot_id=1, @rune_id=5251>, <Lol::RuneSlot: @rune_slot_id=2, @rune_id=5251>, <Lol::RuneSlot: @rune_slot_id=3, @rune_id=5251>, <Lol::RuneSlot: @rune_slot_id=4, @rune_id=5251>, <Lol::RuneSlot: @rune_slot_id=5, @rune_id=5251>, <Lol::RuneSlot: @rune_slot_id=6, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=7, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=8, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=9, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=10, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=11, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=12, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=13, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=14, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=15, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=16, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=17, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=18, @rune_id=5311>, <Lol::RuneSlot: @rune_slot_id=19, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=20, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=21, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=22, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=23, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=24, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=25, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=26, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=27, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=28, @rune_id=5335>, <Lol::RuneSlot: @rune_slot_id=29, @rune_id=5337>, <Lol::RuneSlot: @rune_slot_id=30, @rune_id=5337>]>, <Lol::RunePage: @id=9904744, @name="MID", @current=false, @slots=[<Lol::RuneSlot: @rune_slot_id=1, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=2, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=3, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=4, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=5, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=6, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=7, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=8, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=9, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=10, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=11, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=12, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=13, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=14, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=15, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=16, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=17, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=18, @rune_id=5316>, <Lol::RuneSlot: @rune_slot_id=19, @rune_id=5298>, <Lol::RuneSlot: @rune_slot_id=20, @rune_id=5298>, <Lol::RuneSlot: @rune_slot_id=21, @rune_id=5298>, <Lol::RuneSlot: @rune_slot_id=22, @rune_id=5298>, <Lol::RuneSlot: @rune_slot_id=23, @rune_id=5298>, <Lol::RuneSlot: @rune_slot_id=24, @rune_id=5298>, <Lol::RuneSlot: @rune_slot_id=25, @rune_id=5298>, <Lol::RuneSlot: @rune_slot_id=26, @rune_id=5298>, <Lol::RuneSlot: @rune_slot_id=27, @rune_id=5298>, <Lol::RuneSlot: @rune_slot_id=28, @rune_id=5357>, <Lol::RuneSlot: @rune_slot_id=29, @rune_id=5357>, <Lol::RuneSlot: @rune_slot_id=30, @rune_id=5357>]>, <Lol::RunePage: @id=9904745, @name="AS/MPEN", @current=false, @slots=[<Lol::RuneSlot: @rune_slot_id=1, @rune_id=5273>, <Lol::RuneSlot: @rune_slot_id=2, @rune_id=5273>, <Lol::RuneSlot: @rune_slot_id=3, @rune_id=5273>, <Lol::RuneSlot: @rune_slot_id=4, @rune_id=5273>, <Lol::RuneSlot: @rune_slot_id=5, @rune_id=5273>, <Lol::RuneSlot: @rune_slot_id=6, @rune_id=5273>, <Lol::RuneSlot: @rune_slot_id=7, @rune_id=5273>, <Lol::RuneSlot: @rune_slot_id=8, @rune_id=5273>, <Lol::RuneSlot: @rune_slot_id=9, @rune_id=5273>, <Lol::RuneSlot: @rune_slot_id=10, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=11, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=12, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=13, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=14, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=15, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=16, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=17, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=18, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=19, @rune_id=5297>, <Lol::RuneSlot: @rune_slot_id=20, @rune_id=5297>, <Lol::RuneSlot: @rune_slot_id=21, @rune_id=5297>, <Lol::RuneSlot: @rune_slot_id=22, @rune_id=5297>, <Lol::RuneSlot: @rune_slot_id=23, @rune_id=5297>, <Lol::RuneSlot: @rune_slot_id=24, @rune_id=5297>, <Lol::RuneSlot: @rune_slot_id=25, @rune_id=5297>, <Lol::RuneSlot: @rune_slot_id=26, @rune_id=5297>, <Lol::RuneSlot: @rune_slot_id=27, @rune_id=5297>, <Lol::RuneSlot: @rune_slot_id=28, @rune_id=5337>, <Lol::RuneSlot: @rune_slot_id=29, @rune_id=5337>, <Lol::RuneSlot: @rune_slot_id=30, @rune_id=5337>]>, <Lol::RunePage: @id=9904746, @name="Hybrid AD", @current=false, @slots=[<Lol::RuneSlot: @rune_slot_id=1, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=2, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=3, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=4, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=5, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=6, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=7, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=8, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=9, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=10, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=11, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=12, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=13, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=14, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=15, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=16, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=17, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=18, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=19, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=20, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=21, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=22, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=23, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=24, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=25, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=26, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=27, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=28, @rune_id=5335>, <Lol::RuneSlot: @rune_slot_id=29, @rune_id=5335>, <Lol::RuneSlot: @rune_slot_id=30, @rune_id=5335>]>, <Lol::RunePage: @id=9904747, @name="ADlol", @current=false, @slots=[<Lol::RuneSlot: @rune_slot_id=1, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=2, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=3, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=4, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=5, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=6, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=7, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=8, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=9, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=10, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=11, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=12, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=13, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=14, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=15, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=16, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=17, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=18, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=19, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=20, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=21, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=22, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=23, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=24, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=25, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=26, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=27, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=28, @rune_id=5335>, <Lol::RuneSlot: @rune_slot_id=29, @rune_id=5335>, <Lol::RuneSlot: @rune_slot_id=30, @rune_id=5335>]>, <Lol::RunePage: @id=60039590, @name="Janna Tanky", @current=false, @slots=[<Lol::RuneSlot: @rune_slot_id=1, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=2, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=3, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=4, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=5, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=6, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=7, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=8, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=9, @rune_id=5402>, <Lol::RuneSlot: @rune_slot_id=10, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=11, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=12, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=13, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=14, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=15, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=16, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=17, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=18, @rune_id=5315>, <Lol::RuneSlot: @rune_slot_id=19, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=20, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=21, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=22, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=23, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=24, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=25, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=26, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=27, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=28, @rune_id=5347>, <Lol::RuneSlot: @rune_slot_id=29, @rune_id=5347>, <Lol::RuneSlot: @rune_slot_id=30, @rune_id=5347>]>, <Lol::RunePage: @id=60219808, @name="Nocturne", @current=true, @slots=[<Lol::RuneSlot: @rune_slot_id=1, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=2, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=3, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=4, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=5, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=6, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=7, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=8, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=9, @rune_id=5245>, <Lol::RuneSlot: @rune_slot_id=10, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=11, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=12, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=13, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=14, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=15, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=16, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=17, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=18, @rune_id=5317>, <Lol::RuneSlot: @rune_slot_id=19, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=20, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=21, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=22, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=23, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=24, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=25, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=26, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=27, @rune_id=5289>, <Lol::RuneSlot: @rune_slot_id=28, @rune_id=5337>, <Lol::RuneSlot: @rune_slot_id=29, @rune_id=5337>, <Lol::RuneSlot: @rune_slot_id=30, @rune_id=5337>]>]}

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
 - 0.13.0 Added rate limiting support
 - 0.12.0 Added championmastery endpoint
 - ...
 - 0.9.14 Fixed a caching bug
 - 0.9.13 Updated to latest API versions
 - 0.9.12 Fixed a caching bug
 - 0.9.11 Added caching support via REDIS
 - 0.9.7 Updated LeagueRequest to API v2.3
 - 0.9.6 Updated SummonerRequest and GameRequest to API v1.3
 - 0.9.5 Fixed documentation
 - 0.9.4 Completed support for updated API


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/mikamai/ruby-lol/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
