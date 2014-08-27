# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "streeteasy/version"

Gem::Specification.new do |s|
  s.name            = 'streeteasy'
  s.version         = StreetEasy::VERSION
  s.summary         = %q{Simple StreetEasy API}
  s.description     = %q{Simple StreetEasy API to fetch the top selling properties in NYC}
  s.authors         = ["Derrick Ellerbie"]
  s.email           = 'dellerbie@gmail.com'
  s.homepage        = 'http://github.com/dellerbie/streeteasy'
  s.license         = 'MIT'
  
  s.files           = `git ls-files`.split("\n")
  s.test_files      = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables     = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths   = ["lib"]
  
  s.add_development_dependency 'rake', '~> 10.1'
  s.add_development_dependency 'vcr', '~> 2.9'
  s.add_development_dependency 'webmock', '~> 1.18'
  s.add_runtime_dependency 'nokogiri', '~> 1.6'
end