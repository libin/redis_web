module AppConfig
  def self.root
    APP_ROOT
  end

  module Redis
    OPTIONS = YAML::load(File.open(File.join(APP_ROOT, 'config', 'redis.yml')))

    def self.connection
      @redis ||= ::Redis.new(OPTIONS)
    end
  end
end
