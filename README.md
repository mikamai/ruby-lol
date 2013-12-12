# ruby-lol
[![Coverage Status](https://coveralls.io/repos/mikamai/ruby-lol/badge.png)](https://coveralls.io/r/mikamai/ruby-lol) [![Build Status](https://travis-ci.org/mikamai/ruby-lol.png?branch=master)](https://travis-ci.org/mikamai/ruby-lol) [![Code Climate](https://codeclimate.com/repos/52a9908c56b102320a0166a4/badges/7e5d4ea4fe9e562f8e4d/gpa.png)](https://codeclimate.com/repos/52a9908c56b102320a0166a4/feed)

ruby-lol is a wrapper to the Riot Games API.

## Installation

Add this line to your application's Gemfile:

    gem 'ruby-lol'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby-lol

## Usage

    require 'lol'

    # defaults to euw
    client = Lol::Client.new "my_api_key"
    #<Lol::Client:0x007fd09d1abb00 @api_key="my_api_key", @region="euw">

    # na
    na_client = Lol::Client.new "my_api_key", :region => "na"
    # => <Lol::Client:0x007fd09d1abb00 @api_key="my_api_key", @region="na">

    # gets all champions
    champions = client.champion
    # => Array of Lol::Champion

    # let's play a bit, who is free to play?
    client.champion.select {|c| c.free_to_play }.map {|c| c.name}
    # => %w(Aatrox Cassiopeia Lux Malphite MissFortune MonkeyKing Nautilus Sivir Talon Taric)
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
