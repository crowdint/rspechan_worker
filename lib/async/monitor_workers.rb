module Async
  class MonitorWorkers
    class << self
      def queue
        ::RspechanWorker::Namespace.queue
      end

      def perform *args
        key = [(Tr8sque.redis.is_a?(Tr8dis::Namespace) ? Tr8sque.redis.namespace : '' ), ::RspechanWorker::Namespace.queue].join(':')
        if Tr8sque.redis.llen(key).eql?(0)
          Tr8sque.workers.each do |worker|
            worker.shutdown
          end
        end
        ::RspechanWorker::Notifier.finish_build args.first
      end
    end
  end
end