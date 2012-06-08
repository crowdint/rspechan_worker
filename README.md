# RspechanWorker

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'rspechan_worker'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspechan_worker

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Running locally

Enqueue specs:
    REDIS_HOSTNAME='localhost:6379' APPLICATION_NAME=test bundle exec rake rspechan:enqueue_specs --trace

Start worker:
    RAILS_ENV=test QUEUE=queue_test APPLICATION_NAME=test REDIS_HOSTNAME='localhost:6379' BUILD_ID=27 DUMP_FAILURES_URL='localhost'  bundle exec rake environment tr8sque:work VVERBOSE=1 --trace