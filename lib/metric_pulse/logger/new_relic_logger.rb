require 'newrelic_rpm'

module MetricPulse
  module Logger
    class NewRelicLogger < MetricPulse::Logger::Base
      subscribe

      class << self
        def behavior(payload)
          custom_metric = Oj.load(payload).deep_symbolize_keys

          NewRelic::Agent.record_metric(generate_custom_metric_key(custom_metric[:key]), custom_metric[:value]) if NewRelic::Agent.instance.started?
        end

        private

        def generate_custom_metric_key(key)
          "Custom/#{MetricPulse::Env.env.capitalize}/#{key.capitalize}"
        end
      end
    end
  end
end