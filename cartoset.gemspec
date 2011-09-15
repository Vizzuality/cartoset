# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cartoset/version"

Gem::Specification.new do |s|
  s.name        = "cartoset"
  s.version     = Cartoset::VERSION
  s.authors     = ["Fernando Espinosa"]
  s.email       = ["ferdev@vizzuality.com"]
  s.homepage    = "http://vizzuality.com/cartoset"
  s.summary     = %q{A great tool that allows us to create beautiful geospatial projects for you in less time and less money}

  s.rubyforge_project = "cartoset"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "rails", "3.0.5"
  s.add_runtime_dependency "cartodb-rb-client", "~> 0.1.1"
  s.add_runtime_dependency "sass", "~> 3.1.0"
end
