begin
  require 'rspec'
rescue LoadError => e
end

begin
  require 'spec'
rescue LoadError => e
end

if defined? ::RSpec::Core::Version::STRING
  # rspec >= 2.x
  RSPEC_VERSION_2 = true
elsif defined? ::Spec::VERSION::STRING
  # rspec 1.x
  RSPEC_VERSION_2 = false
else
  # some unsupported version. Let's assume that it is something like rspec 2.x
  # such require may force gem activation
  RSPEC_VERSION_2 = true
end

require 'rspechan_worker/version'
require 'async/rspechan_worker'
require 'rspec/formatters/rspechan_formatter'
require 'rspechan_worker/proxy_results'
require 'rspechan_worker/logger'
require 'rspechan_worker/namespace'
require 'tasks/rspechan'
require 'tasks/tr8sque'
