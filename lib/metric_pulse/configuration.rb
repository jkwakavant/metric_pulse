## WIP: need to figure out what additional metric we want to maintain via the gem

module MetricPulse
  class << self
    attr_accessor :conf_file

    def configure
      yield self
      @conf_file ||= "metric_pulse.yml"
    end
  end
end