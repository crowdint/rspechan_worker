require 'spec_helper'
describe RspechanWorker::Async::MonitorWorkers do
  describe ".perform" do
    it "marks as finished the build" do
      Net::HTTP.should_receive(:post_form).with(URI('localhost:3000/api/builds/finish_build'), :id => 1)
      RspechanWorker::Async::MonitorWorkers.perform :build_id => 1, :dump_failures_url => 'localhost:3000'
    end
  end
end