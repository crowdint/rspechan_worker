module RspechanWorker
  class Notifier

    def self.finish_build id
      url = URI("#{ENV['DUMP_FAILURES_URL']}/api/builds/finish_build")
      Net::HTTP.post_form(url, :id => id)
    end
  end
end