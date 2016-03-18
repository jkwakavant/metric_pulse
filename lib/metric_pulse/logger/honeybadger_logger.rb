require 'honeybadger'

module MetricPulse
  module Logger
    class HoneybadgerLogger < MetricPulse::Logger::Base
      subscribe

      class << self
        def behavior(payload)
          custom_metric = Oj.load(payload).deep_symbolize_keys
          Oj.default_options = {:mode => :compat}

          ## TO-DO: we can report custom metric as well to honeybadger depending on the key
          Honeybadger.notify(custom_metric[:value]) if MetricPulse::Env.production? && Honeybadger::Agent.running?
        end
      end
    end
  end
end
