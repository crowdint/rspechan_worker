if RSPEC_VERSION_2
  # rspec >= 2.x
  require 'rspec/core/formatters/base_formatter'
else
  # rspec 1.x
  require 'spec/runner/formatter/base_formatter'
end

require 'json'

module RSpec
  module Formatters
    class RspechanFormatter < (RSPEC_VERSION_2 ? RSpec::Core::Formatters::BaseFormatter : Spec::Runner::Formatter::BaseFormatter)

      def example_started(*example_proxy)
        super
        print "."
      end


      def example_failed(*example)
        super
        print "F"
        RspechanWorker::ProxyResults.instance.add_failed_example *example
        dump_failures
      end

      def dump_failures
        super if RSPEC_VERSION_2

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
        url = URI("#{ENV['DUMP_FAILURES_URL']}/api/specs/create_failures")
        require 'net/http'
        Net::HTTP.post_form(url, :specs => specs.to_json, :build_id => ENV['BUILD_ID'])
      end
    end
  end
end
