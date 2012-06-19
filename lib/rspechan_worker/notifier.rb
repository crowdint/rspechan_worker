require 'net/http'
module RspechanWorker
  class Notifier

    def self.finish_build args = {}
      url = URI("#{args[:dump_failures_url]}/api/builds/finish_build")
      Net::HTTP.post_form(url, :id => args[:build_id])
    end
  end
end