class RedisAbstractor
  def self.redis
    AppConfig::Redis.instance
  end

  def self.keys(pattern='*')
    redis.keys(pattern)
  end

  def self.get(keys)
    keys.collect do |key|
      type  = RedisCommand.type(key)
      value = RedisCommand.get(type, key)
      ttl   = RedisCommand.ttl(key)
      {'key' => key, 'ttl' => ttl, 'type' => type, 'value' => value}
    end
  end

  def self.del(key)
    redis.del(key)
  end
end
