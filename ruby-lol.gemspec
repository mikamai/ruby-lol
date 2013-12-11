# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lol/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby-lol"
  spec.version       = Lol::VERSION
  spec.authors       = ["Giovanni Intini"]
  spec.email         = ["giovanni@mikamai.com"]
  spec.description   = %q{Ruby wrapper to Riot Games API. Maps results to full blown ruby objects.}
  spec.summary       = %q{Ruby wrapper to Riot Games API}
  spec.homepage      = "https://github.com/mikamai/ruby-lol"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "redcarpet"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "ZenTest"
  spec.add_development_dependency "autotest-growl"
  spec.add_development_dependency "autotest-fsevent"
  spec.add_development_dependency "codeclimate-test-reporter"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock", ">= 1.8.0", "< 1.16"
  spec.add_development_dependency "awesome_print"

  spec.add_runtime_dependency "httparty"
end
