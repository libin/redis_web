module AppConfig
  def self.root
    APP_ROOT
  end

  class Redis
    OPTIONS = YAML::load(File.open(File.join(APP_ROOT, 'config', 'redis.yml')))

    def self.instance
      @redis ||= ::Redis.new(OPTIONS)
    end
  end
end
