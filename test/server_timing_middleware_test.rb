require 'test_helper'
require 'active_support/notifications'

# TODO(javierhonduco): test the proper addition of events
# with the same name
class ServerTimingMiddlewareTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ServerTimingMiddleware::VERSION
  end

  def test_no_notifications
    status, headers, body = Rack::ServerTimingMiddleware.new(FakeRack.new).call(nil)
    server_timing = headers['Server-Timing']

    refute_nil server_timing
    assert_empty server_timing
  end

  def test_multiple_notifications_simple
    status, headers, body = Rack::ServerTimingMiddleware.new(SimpleMockedRack.new).call(nil)
    server_timing = headers['Server-Timing']

    assert_match /omg;dur=.+;desc="omg",lol;dur=.+;desc="lol",kawaii;dur=.+;desc="kawaii"/, server_timing
  end
end
