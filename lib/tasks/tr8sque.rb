namespace :tr8sque do
  task :setup do
    puts '*'*100
    puts "Setting up redis hostname and namespace"
    Tr8sque.redis = File.join(ENV['REDIS_HOSTNAME'], RspechanWorker::Namespace.name)
  end
end
