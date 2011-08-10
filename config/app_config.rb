module AppConfig
  module Redis
    OPTIONS = {
      :host => 'localhost',
      :port => 6379
    }

    def self.connection
      @redis ||= ::Redis.new(OPTIONS)
    end
  end
end
