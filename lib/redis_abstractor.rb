class RedisAbstractor
  def self.redis
    AppConfig::Redis.instance
  end

  def self.keys
    redis.keys
  end

  def self.get(keys)
    keys.collect do |key|
      type = RedisCommand.type(key)
      value = RedisCommand.get(type, key)
      {'key' => key, 'type' => type, 'value' => value}
    end
  end
end
