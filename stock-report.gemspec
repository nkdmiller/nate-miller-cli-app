lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "stock/report/version"

Gem::Specification.new do |spec|
  spec.name          = "stock-report"
  spec.version       = Stock::Report::VERSION
  spec.authors       = ["Nate Miller"]
  spec.email         = ["natekmiller96@gmail.com"]

  spec.summary       = "Reports Stocks"
  spec.description   = "Reports Stocks"
  spec.homepage      = "https://learn.co"
  spec.license       = "MIT"
  spec.files         = `git ls-files`.split($\)
  spec.executables   = ["stock-report"]
  spec.require_paths = ["lib", "lib/stock-report"]
  spec.require_paths = ["bin", "bin/stock-report"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end