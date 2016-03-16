require 'newrelic_rpm'

module MetricPulse
  module Logger
    class NewRelicLogger < MetricPulse::Logger::Base
      subscribe

      class << self
        def behavior(payload)
          custom_metric = Oj.load(payload).deep_symbolize_keys
          NewRelic::Agent.record_metric(custom_metric[:key], custom_metric[:value])
        end
      end
    end
  end
end