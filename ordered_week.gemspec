# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
#require 'ordered_week/version'
require 'ordered_week'

Gem::Specification.new do |spec|
  spec.name          = "ordered_week"
  spec.version       = OrderedWeek::VERSION
  spec.authors       = ["Brad Rice"]
  spec.email         = ["bradley_rice@mac.com"]
  spec.summary       = %q{A customizable ordered collection of Dates}
  spec.description   = %q{Useful for situations in which the concept of a week requires a specific start/stop marker}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_development_dependency "rspec", "~> 3.4"
end
