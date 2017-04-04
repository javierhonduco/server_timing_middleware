$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'server_timing_middleware'

require 'minitest/autorun'

class FakeRack
  def initialize
  end

  def call(env)
    [200, {}, '']
  end
end

class SimpleMockedRack
  def initialize
  end

  def call(env)
    ActiveSupport::Notifications.instrument('omg', {})
    ActiveSupport::Notifications.instrument('lol', {})
    ActiveSupport::Notifications.instrument('kawaii', {})
    [200, {}, '']
  end
end
