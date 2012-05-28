module RspechanWorker
  class Namespace
    class << self
      def name
        "rspechan:#{ENV['APPLICATION_NAME'] || 'default'}"
      end
    end
  end
end