module AppConfig
  def self.root
    APP_ROOT
  end

  class Redis
    if ENV['RUBY_ENV'] == 'test'
      OPTIONS = {:host => 'localhost', :port => 6380}
    else
      OPTIONS = YAML::load(File.open(File.join(APP_ROOT, 'config', 'redis.yml')))
    end

    def self.instance
      @redis ||= ::Redis.new(OPTIONS)
    end
  end
end
