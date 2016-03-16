module MetricPulse
  @default_env = ENV["DEFAULT_ENV"] || ENV['RAILS_ENV'] || (RAILS_ENV if defined?(RAILS_ENV)) || (Rails.env if defined?(Rails)) || 'development'

  class << self
    attr_writer :env

    def env
      @env ||= @default_env
    end
  end
end