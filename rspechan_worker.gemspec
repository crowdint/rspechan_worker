# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rspechan_worker/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Edwin Cruz"]
  gem.email         = ["edwin.cruz@crowdint.com"]
  gem.description   = %q{Rspechan CI Server client}
  gem.summary       = %q{This gem helps rspechan CI server to run tests in parallel across multiple nodes}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "rspechan_worker"
  gem.require_paths = ["lib"]
  gem.version       = RspechanWorker::VERSION

  gem.add_development_dependency('rspec')
  gem.add_dependency('resque')
end
