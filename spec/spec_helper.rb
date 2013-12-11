require "rubygems"
require "rspec"
require "simplecov"
require "coveralls"
require "vcr"

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  Coveralls::SimpleCov::Formatter,
  SimpleCov::Formatter::HTMLFormatter,
]

SimpleCov.start

VCR.configure do |c|
  c.cassette_library_dir = __dir__ + '/../fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end
