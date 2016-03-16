require 'honeybadger'

module MetricPulse
  module Logger
    class HoneybadgerLogger < MetricPulse::Logger::Base
      subscribe

      class << self
        def behavior(payload)
          exception = Oj.load(payload)
          Honeybadger.notify(exception) if Rails.env.production?
        end
      end
    end
  end
end