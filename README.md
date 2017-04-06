# ServerTimingMiddleware

[![Build Status](https://travis-ci.org/javierhonduco/server_timing_middleware.svg?branch=master)](https://travis-ci.org/javierhonduco/server_timing_middleware)

This is a simple Rack Middleware that can be plugged in apps which use `ActiveSupport::Notifications` such as Rails apps, to retrieve all the events and send them as a header so they can be seen in Server Timing compliant clients, such as Chrome's `Network > Timing`.

:warning: Take into account this has not been tested in production. It might have memory leaks or slow down your application.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'server_timing_middleware'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install server_timing_middleware
```

## Usage

Plug in to your app's Middleware chain.

In Rails, that could be in `config/application.rb` with something like

```ruby
config.middleware.use Rack::ServerTimingMiddleware
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/javierhonduco/server_timing_middleware. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
