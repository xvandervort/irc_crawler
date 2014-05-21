# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'irc_crawler/version'

Gem::Specification.new do |spec|
  spec.name          = "irc_crawler"
  spec.version       = IrcCrawler::VERSION
  spec.authors       = ["Dave Vandervort"]
  spec.email         = ["david.vandervort@xerox.com"]
  spec.description   = %q{records irc stream as individual comments (somewhat similar to twitter)}
  spec.summary       = %q{Configurable gem for pulling irc comments }
  spec.homepage      = ""
  spec.license       = "MIT"
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib", "lib/irc_crawler"]
  spec.add_development_dependency "rake"
end
