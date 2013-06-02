# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'farmers_market_cal/version'

Gem::Specification.new do |spec|
  spec.name          = "farmers_market_cal"
  spec.version       = FarmersMarketCal::VERSION
  spec.authors       = ["Justin Love"]
  spec.email         = ["git@JustinLove.name"]
  spec.description   = %q{Present data from the USDA Farmer's Market API as an iCalendar Feed}
  spec.summary       = %q{Primarily intended to run as a Heroku app}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = <<FILES.split($/)
LICENSE.txt
Rakefile
README.md
FILES
  spec.test_files    = <<TEST.split($/)
spec/spec_helper.rb
TEST
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "json"
  spec.add_runtime_dependency "icalendar2"
  spec.add_runtime_dependency "sinatra"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-process"
  spec.add_development_dependency "foreman"
end
