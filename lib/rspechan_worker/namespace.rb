module RspechanWorker
  class Namespace
    class << self
      def name
        "rspechan"
      end

      def queue
        "queue_" + (ENV['APPLICATION_NAME'] || 'default')
      end
    end
  end
end