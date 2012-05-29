require 'rspec/core/formatters/base_formatter'
require 'json'

module RSpec
  module Formatters
    class RspechanFormatter < RSpec::Core::Formatters::BaseFormatter
      def example_failed(example)
        super
        RspechanWorker::ProxyResults.instance.add_failed_example example
      end

      def dump_failures
        super
        specs =  []
        RspechanWorker::ProxyResults.instance.failed_examples.each do |failed_spec|
          specs << {
              exception: failed_spec.exception.to_s,
              build_id: ENV['BUILD_ID'],
              description: failed_spec.metadata[:description],
              file_path: failed_spec.metadata[:file_path].split('/spec/').last,
              spec: failed_spec.metadata[:full_description],
              line: failed_spec.metadata[:line_number]
          }
        end

        url = "#{ENV['DUMP_FAILURES_URL']}/api/specs/create_failures"
        Typhoeus::Request.post(url, params: {specs: specs.to_json})
      end
    end
  end
end
