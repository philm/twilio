# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "twilio/version"

Gem::Specification.new do |s|
  s.name        = "slayer-twilio"
  s.version     = Twilio::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Phil Misiowiec", "Jonathan Rudenberg", "Alex K Wolfe", "Kyle Daigle", "Jeff Wigal", "Yuri Gadow", "Vlad Moskovets"]
  s.email       = ["github@webficient.com", "github@vlad.org.ua"]
  s.homepage    = ""
  s.summary     = %q{Twilio API Client}
  s.description = %q{Twilio API wrapper}

  s.rubyforge_project = "twilio"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "builder", ">= 2.1.2"
  s.add_dependency "httparty", "~> 0.7.4"

  {
    'rake'    => '~> 0.8.7',
    'rspec'   => '~> 2.5.0',
    'webmock' => '~> 1.6.2'
  }.each { |l, v| s. add_development_dependency l, v }
end
