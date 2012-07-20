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

  s.add_runtime_dependency 'rails', '>= 3.2.3'
  s.add_dependency 'oa-core', '0.2.6'
  s.add_dependency 'oa-oauth', '0.2.6'
  s.add_dependency 'warden',      '1.0.3'
  s.add_dependency 'rails_warden', '0.5.2'
  s.add_dependency 'cartodb-rb-client', '~> 0.3.0'
end
