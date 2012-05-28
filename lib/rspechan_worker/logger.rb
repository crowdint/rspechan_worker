module RspechanWorker
  class Logger < IO
    attr_accessor :logger
    def initialize(file_name)
      @logger = ::Logger.new(file_name)
    end

    def write(message)
      @logger.info message
    end
  end
end