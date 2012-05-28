require 'rspec/core/formatters/base_formatter'

module RSpec
  module Formatters
    class RspechanFormatter < RSpec::Core::Formatters::BaseFormatter
      def example_failed(example)
        super
        RspechanWorker::ProxyResults.instance.add_failed_example example
      end
    end
  end
end
