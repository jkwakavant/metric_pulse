module MetricPulse
  class << self
    attr_accessor :conf_file

    def configure
      yield self
      @conf_file ||= "test_file.yml"
    end
  end
end