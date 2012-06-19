require 'spec_helper'
describe RspechanWorker::Async::RspechanWorker do
  describe ".perform" do
    before do
      RSPEC_VERSION_2 = true
      RspechanWorker::Async::RspechanWorker.stub(:shutdown)
    end
    it "invokes monitor workers process" do
      RSpec::Core::Runner.should_receive(:run).with(any_args).and_return(true)
      RspechanWorker::Async::MonitorWorkers.should_receive(:perform).with any_args
      RspechanWorker::Async::RspechanWorker.perform({:spec_name => 'asdf.rb', :build_id => 1, :dump_failures_url => 'localhost:3000'})
    end
  end
end