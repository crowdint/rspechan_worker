module Async
  class RspechanWorker

    def self.queue
      ::RspechanWorker::Namespace.queue
    end

    def self.perform *args
      #$stderr = ::RspechanWorker::Logger.new('log/stderror.log')
      #$stdout = ::RspechanWorker::Logger.new('log/stdout.log')
      spec = args.first['spec_name']
      ops = [spec, '--format', 'RSpec::Formatters::RspechanFormatter'].flatten
      if defined?(Rspec)
        RSpec::Core::Runner.run(ops)
      else
        require 'spec'
        require 'spec/runner/option_parser'
        require 'spec/runner'

        parser = ::Spec::Runner::OptionParser.new($stderr, $stdout)
        parser.order!(ops)
        options = parser.options
        Spec::Runner.use options
        options.run_examples
      end

      Async::MonitorWorkers.perform ENV['BUILD_ID']
    end
  end
end