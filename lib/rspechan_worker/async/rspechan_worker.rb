module RspechanWorker
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
        if RSPEC_VERSION_2
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

        ::RspechanWorker::Async::MonitorWorkers.perform :build_id => args.first['build_id'], :dump_failures_url => args.first['dump_failures_url']
        shutdown
      end
    end
  end
end
