require "rubygems"
require "rspec"
require "simplecov"
require "codeclimate-test-reporter"
require "coveralls"
require "vcr"

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  Coveralls::SimpleCov::Formatter,
  SimpleCov::Formatter::HTMLFormatter,
  CodeClimate::TestReporter::Formatter
]

SimpleCov.start

VCR.configure do |c|
  c.cassette_library_dir = __dir__ + '/../fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.ignore_hosts 'codeclimate.com'
  c.configure_rspec_metadata!
end
