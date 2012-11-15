# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'johnny5/version'

Gem::Specification.new do |gem|
  gem.name          = "johnny5"
  gem.version       = Johnny5::VERSION
  gem.authors       = ["Anurag Mohanty"]
  gem.email         = ["anurag@columbia.edu"]
  gem.description   = %q{something something something}
  gem.summary       = %q{Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency "nokogiri"
end
