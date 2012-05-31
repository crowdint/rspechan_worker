require defined?(RSpec) ? 'rspec/core/formatters/base_formatter' : 'spec/runner/formatter/base_formatter'
require 'json'

if defined?(Spec)
  class BaseFormatter < Spec::Runner::Formatter::BaseFormatter;end
else
  class BaseFormatter < RSpec::Core::Formatters::BaseFormatter;end
end

module RSpec
  module Formatters
    class RspechanFormatter < BaseFormatter

      def example_started(*example_proxy)
        puts "."
      end


      def example_failed(*example)
        super
        RspechanWorker::ProxyResults.instance.add_failed_example *example
      end

      def dump_failures
        super

        return if RspechanWorker::ProxyResults.instance.failed_examples.empty?

        specs = []
        RspechanWorker::ProxyResults.instance.failed_examples.each do |failed_spec|
          specs << {
              :exception => failed_spec[:exception],
              :build_id => ENV['BUILD_ID'],
              :description => failed_spec[:description],
              :file_path => failed_spec[:file_path],
              :spec => failed_spec[:spec],
              :line => failed_spec[:line_number]
          }
        end

        url = "#{ENV['DUMP_FAILURES_URL']}/api/specs/create_failures"
        Typhoeus::Request.post(url, :params => {:specs => specs.to_json})
      end
    end
  end
end
