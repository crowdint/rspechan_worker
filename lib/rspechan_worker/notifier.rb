module RspechanWorker
  class Notifier

    def self.finish_build id
      url = "#{ENV['DUMP_FAILURES_URL']}/api/builds/finish_build"
      Typhoeus::Request.post(url, :params => {:id => id})
    end
  end
end