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

  task :start_workers do
    queues = ENV['QUEUE']
    application = ENV['APPLICATION']
    redis_hostname = ENV['REDIS_HOSTNAME']
    build_id = ENV['BUILD_ID']
    main_app_url = ENV['DUMP_FAILURES_URL']
    system "RAILS_ENV=test QUEUE=#{queues} APPLICATION_NAME=#{application} REDIS_HOSTNAME=#{redis_hostname} BUILD_ID=#{build_id} DUMP_FAILURES_URL=#{main_app_url}  bundle exec rake environment tr8sque:work 2>&1 >> log/tr8sque_workers.log &"
  end
end
