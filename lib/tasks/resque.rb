if ENV['APPLICATION_NAME']
  namespace :resque do
    task :setup do
      Resque.redis = ENV['REDIS_HOSTNAME']
      Resque.redis.namespace = RspechanWorker::Namespace.name
    end
  end
end