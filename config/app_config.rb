module AppConfig
  def self.root
    APP_ROOT
  end

  class Redis
    # this should match your config file; currently no way to query redis for this value
    MAX_DATABASES = 16

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
    options = {}
    YAML::load(File.open(File.join(APP_ROOT, 'config', 'redis.yml'))).each{|k, v| options[k.to_sym] = v}
    Redis.options = options
  end
end
