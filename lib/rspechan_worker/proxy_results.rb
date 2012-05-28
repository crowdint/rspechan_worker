require 'singleton'

module RspechanWorker
  class ProxyResults
    include Singleton
    attr_accessor :failed_examples

    def initialize
      @failed_examples = []
    end

    def add_failed_example example
      puts "*"*100
      puts example.exception
      puts example.metadata[:full_description]
      puts example.metadata[:file_path]
      puts example.metadata[:line_number]
      @failed_examples << example
    end
  end
end
