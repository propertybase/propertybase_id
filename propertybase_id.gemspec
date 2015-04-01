# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "propertybase_id/version"

Gem::Specification.new do |spec|
  spec.name          = "propertybase_id"
  spec.version       = PropertybaseId::VERSION
  spec.authors       = ["Leif Gensert"]
  spec.email         = ["leif@propertybase.com"]

  spec.summary       = %q{Gem for creating Propertybase compatible IDs}
  spec.description   = %q{This gem lets you create IDs in the Propertybase universe. Still under heavy development}
  spec.homepage      = "http://www.propertybase.com"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
end
