# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby/lol/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby-lol"
  spec.version       = Ruby::Lol::VERSION
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
end
