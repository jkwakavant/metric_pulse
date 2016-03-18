require 'honeybadger'

module MetricPulse
  module Logger
    class HoneybadgerLogger < MetricPulse::Logger::Base
      subscribe

      class << self
        def behavior(payload)
          custom_metric = Oj.load(payload).deep_symbolize_keys
          Oj.default_options = {:mode => :compat}

          if custom_metric[:key] == 'exception'
            Honeybadger.notify(custom_metric[:value]) if MetricPulse::Env.production? && Honeybadger::Agent.running?
          else
            ## TO-DO: what do we want here?
          end
        end
      end
    end
  end
end
