require "rspec"
require "simplecov"
require "coveralls"
require "codeclimate-test-reporter"
require "vcr"

SPEC_ROOT = __dir__

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new [
  Coveralls::SimpleCov::Formatter,
  SimpleCov::Formatter::HTMLFormatter
]

SimpleCov.start

VCR.configure do |c|
  c.cassette_library_dir = File.join(SPEC_ROOT, '..', 'fixtures', 'vcr_cassettes')
  c.hook_into :webmock
  c.ignore_hosts 'codeclimate.com'
  c.configure_rspec_metadata!
end

RSpec.configure do |c|
#  c.fail_fast = true
  c.filter_run_excluding :remote => true
  c.include Helpers
end
