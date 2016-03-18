require 'bunny'

module MetricPulse
  module Logger
    class Base
      class << self
        def close
          @conn.close unless @conn.nil?
        end

        def report(payload, routing_key = nil)
          Oj.default_options = {:mode => :object}
          if routing_key.nil?
            MetricPulse.routing_keys.each do |rk|
              exchange.publish(Oj.dump(payload), :routing_key => rk) if applicable?(payload.deep_symbolize_keys[:key], rk)
            end
          else
            exchange.publish(Oj.dump(payload), :routing_key => routing_key)
          end
        end

        def subscribe
          channel.queue(logger_name).bind(exchange, :routing_key => logger_name).subscribe do |delivery_info, metadata, payload|
            behavior(payload)
          end
        end

        def logger_name
          self.name.demodulize.underscore
        end

        def behavior(payload)
          raise NotImplementedError, "Attempted logging an error message but error is not implemented on #{logger_mame}!"
        end

        private

        def conn
          if @conn.nil?
            @conn = Bunny.new
            @conn.start
          end
          @conn
        end

        def channel
          @channel ||= conn.create_channel
        end

        def exchange(topic = "custom_metric")
          @exchange ||= channel.topic(topic, :auto_delete => true)
        end

        def applicable?(key, routing_key)
          ## TO-DO: need to downcase when we compare this key
          (MetricPulse.allowed_keys && MetricPulse.allowed_keys[routing_key].include?(key)) ? true : false
        end

      end
    end
  end
end
