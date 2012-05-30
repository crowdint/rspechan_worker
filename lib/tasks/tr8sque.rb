namespace :tr8sque do
  task :setup do
    puts '*'*100
    puts "Setting up redis hostname and namespace"
    Tr8sque.redis = ENV['REDIS_HOSTNAME']
    Tr8sque.redis.namespace = RspechanWorker::Namespace.name
  end
end
