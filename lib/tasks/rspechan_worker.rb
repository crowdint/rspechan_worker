require 'rake'
require 'rspec'
Resque.redis = ENV['RESQUE_CONFIG'] || 'localhost'
#$LOAD_PATH.unshift File.dirname(__FILE__) + '/../../lib'
namespace :rspechan do
  desc "Enqueues all rspecs"
  task :enqueue_specs do
    Resque.redis = ENV['REDIS_HOSTNAME']
    Resque.redis.namespace = RspechanWorker::Namespace.name
    Dir.glob('spec/**/*spec.rb').each do |file|
      Resque.enqueue Async::RspechanWorker, {spec_name: file, app_name: ENV['APPLICATION_NAME'] || 'default'}
    end
  end
end