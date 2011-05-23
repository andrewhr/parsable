# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "parsable/version"

Gem::Specification.new do |s|
  s.name        = "parsable"
  s.version     = Parsable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Andrew Rosa"]
  s.email       = ["andrewhr@me.com"]
  s.homepage    = ""
  s.summary     = %q{A gem for easy importing CSV files throught ActiveRecord}
  s.description = %q{A gem for easy importing CSV files throught ActiveRecord}

  s.rubyforge_project = "parsable"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'activerecord', '~> 3.0'
  s.add_development_dependency 'rspec', '~> 2.6.0'
end
