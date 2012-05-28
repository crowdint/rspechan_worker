require 'rake'
require 'rspec'
Resque.redis = ENV['RESQUE_CONFIG'] || 'localhost'
#$LOAD_PATH.unshift File.dirname(__FILE__) + '/../../lib'
namespace :rspechan do
  desc "Enqueues all rspecs"
  task :enqueue_specs do
    Dir.glob('spec/**/*spec.rb').each do |file|
      puts file
      #Resque.enqueue Async::RspechanWorker, {spec_name: file, app_name: ENV['APPLICATION_NAME'] || 'default'}
    end
  end
end