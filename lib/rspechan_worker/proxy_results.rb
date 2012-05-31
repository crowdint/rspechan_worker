require 'singleton'

module RspechanWorker
  class ProxyResults
    include Singleton
    attr_accessor :failed_examples

    def initialize
      @failed_examples = []
    end

    def add_failed_example_rspec13 example_proxy, counter, failure
      error = {
          :exception => failure.exception.to_s,
          :description => example_proxy.description,
          :file_path => example_proxy.location,
          :spec => failure.header,
          :line_number => example_proxy.location
      }
      @failed_examples << error
    end

    def add_failed_example *example
      example.size > 1 ? add_failed_example_rspec13(*example) : add_failed_example_rspec2(*example)
    end

    def add_failed_example_rspec2 example
      error = {
          :exception => example.exception.to_s,
          :description => failed_spec.metadata[:description],
          :file_path => failed_spec.metadata[:file_path].split('/spec/').last,
          :spec => failed_spec.metadata[:full_description],
          :line_number => failed_spec.metadata[:line_number]
      }
      @failed_examples << error
    end
  end
end
