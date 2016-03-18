## WIP: need to figure out what additional metric we want to maintain via the gem

module MetricPulse
  class << self
    attr_accessor :allowed_keys
    attr_accessor :routing_keys

    def configure
      yield self
      @allowed_keys ||= {}
      @routing_keys ||= ["new_relic_logger", "honeybadger_logger"]
    end
  end
end
