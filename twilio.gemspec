# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "twilio/version"

Gem::Specification.new do |s|
  s.name        = "twilio"
  s.version     = Twilio::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Phil Misiowiec", "Jonathan Rudenberg", "Alex K Wolfe", "Kyle Daigle", "Jeff Wigal", "Yuri Gadow"]
  s.email       = ["github@webficient.com"]
  s.homepage    = ""
  s.summary     = %q{Twilio API Client}
  s.description = %q{Twilio API wrapper}

  s.rubyforge_project = "twilio"

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<builder>, [">= 2.1.2"])
      s.add_runtime_dependency(%q<httparty>, [">= 0.4.3"])
    else
      s.add_dependency(%q<builder>, [">= 2.1.2"])
      s.add_dependency(%q<httparty>, [">= 0.4.3"])
    end
  else
    s.add_dependency(%q<builder>, [">= 2.1.2"])
    s.add_dependency(%q<httparty>, [">= 0.4.3"])
  end

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
