#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :default => :spec

#load 'lib/tasks/rspechan_worker.rake'