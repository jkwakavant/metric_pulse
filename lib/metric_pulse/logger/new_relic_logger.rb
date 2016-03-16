module MetricPulse
  module Logger
    class NewRelicLogger < MetricPulse::Logger::Base
      subscribe

      class << self
        def behavior(payload)
          value = Oj.load(payload)
          NewRelic::Agent.record_metric(payload["key"], payload["value"])
        end
      end
    end
  end
end