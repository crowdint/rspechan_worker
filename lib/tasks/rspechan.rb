require 'rake'
require 'tr8sque'
#$LOAD_PATH.unshift File.dirname(__FILE__) + '/../../lib'
namespace :rspechan do
  desc "Enqueues all rspecs"
  task :enqueue_specs do
    Tr8sque.redis = ENV['REDIS_HOSTNAME']
    Tr8sque.redis.namespace = RspechanWorker::Namespace.name
    Dir.glob('spec/**/*spec.rb').each do |file|
      Tr8sque.enqueue Async::RspechanWorker, {:spec_name => file,
                                              :app_name => ENV['APPLICATION_NAME'] || 'default'}
    end
  end
end