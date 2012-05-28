module Async
  class RspechanWorker
    @queue = ENV['APPLICATION_NAME'] || 'default'

    def self.perform *args
      #$stderr = ::RspechanWorker::Logger.new('log/stderror.log')
      #$stdout = ::RspechanWorker::Logger.new('log/stdout.log')
      spec = args.first[:spec]
      ops = [spec, '--format', 'RSpec::Formatters::RspechanFormatter']
      RSpec::Core::Runner.run(ops)
    end
  end
end