# This simple Rack middleware subscribes to all AS::Notifications
# and adds the appropriate `Server-Timing` header as described in
# the spec [1] with the notifications grouped by name and with the
# elapsed time added up.
#
# [1] Server Timing spec: https://w3c.github.io/server-timing/

module Rack
  class ServerTimingMiddleware
    def initialize(app)
      @app = app
    end
    def call(env)

      events = []

      subs = ActiveSupport::Notifications.subscribe(//) do |*args|
        events << ActiveSupport::Notifications::Event.new(*args)
      end

      status, headers, body = @app.call(env)

      # As the doc states, this harms the internal AS:Notifications
      # caches, but I'd say it's necessary so we don't leak memory
      ActiveSupport::Notifications.unsubscribe(subs)

      mapped_events = events.group_by { |el|
        el.name
      }.map{ |event_name, event_data|
        agg_time = event_data.map{ |ev|
          ev.duration
        }.inject(0){ |curr, accum| curr += accum}

        # We need the string formatter as the scientific notation
        # a.k.a <number>e[+-]<exponent> is not allowed

        # Time divided by 1000 as it's in milliseconds
        [event_name, '%.10f' % (agg_time/1000)]
      }

      # Example output:
      #   'cpu;dur=0.009;desc="CPU", mysql;dur=0.005;desc="MySQL", filesystem;dur=0.006;desc="Filesystem"'
      headers['Server-Timing'] = mapped_events.map do |name, elapsed_time|
        "#{name};dur=#{elapsed_time};desc=\"#{name}\""
      end.join(', ')

      [status, headers, body]
    end
  end
end
