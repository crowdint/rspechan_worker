require 'rake'
require 'tr8sque'
#$LOAD_PATH.unshift File.dirname(__FILE__) + '/../../lib'
namespace :rspechan do
  desc "Enqueues all rspecs"
  task :enqueue_specs do
    Tr8sque.redis = File.join(ENV['REDIS_HOSTNAME'], RspechanWorker::Namespace.name)
    files = Dir.glob('spec/**/*spec.rb')
    files.each_slice((files.size / ENV['NUM_WORKERS'].to_i) + 1) do |files|
      Tr8sque.enqueue Async::RspechanWorker, {:spec_name => files,
                                              :app_name => ENV['APPLICATION_NAME'] || 'default'}
    end
  end
end