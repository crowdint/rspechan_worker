module Async
  class RspechanWorker

    def self.queue
      RspechanWorker::Namespace.queue
    end

    def self.perform *args
      #$stderr = ::RspechanWorker::Logger.new('log/stderror.log')
      #$stdout = ::RspechanWorker::Logger.new('log/stdout.log')
      spec = args.first['spec_name']
      ops = [spec, '--format', 'RSpec::Formatters::RspechanFormatter']
      RSpec::Core::Runner.run(ops)
    end
  end
end