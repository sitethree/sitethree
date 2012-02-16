# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sitethree/version"

Gem::Specification.new do |s|
  s.name        = "sitethree"
  s.version     = Sitethree::VERSION
  s.authors     = ["Shawn O'Neill"]
  s.email       = ["shawn.oneill@gmail.com"]
  s.homepage    = "http://github.com/sitethree/sitethree.git"
  s.summary     = %q{Ruby interface for the Sitethree advertising platform}
  s.description = %q{Ruby interface for the Sitethree advertising platform including the requesting of ads}

  s.rubyforge_project = "sitethree"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "httparty"
end
