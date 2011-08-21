module AppConfig
  def self.root
    APP_ROOT
  end

  class Redis
    def self.options
      @options ||= {}
    end

    def self.options=(options)
      @options = options
    end

    def self.instance
      @redis ||= ::Redis.new(options)
    end

    def self.refresh
      @redis = nil
    end
  end

  if ENV['RUBY_ENV'] == 'test'
    Redis.options = {:host => 'localhost', :port => 6380}
  else
    Redis.options = YAML::load(File.open(File.join(APP_ROOT, 'config', 'redis.yml')))
  end
end
