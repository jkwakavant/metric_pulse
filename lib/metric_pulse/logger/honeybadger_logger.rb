require 'honeybadger'

module MetricPulse
  module Logger
    class HoneybadgerLogger < MetricPulse::Logger::Base
      subscribe

      class << self
        def behavior(payload)
          exception = Oj.load(payload)
          Oj.default_options = {:mode => :compat}
          Honeybadger.notify(exception) if MetricPulse::Env.production?
        end
      end
    end
  end
end