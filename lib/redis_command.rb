class RedisCommand
  def self.redis
    AppConfig::Redis.instance
  end

  def self.type(key)
    redis.type(key)
  end

  def self.get(type, key)
    self.send(type, key)
  end

  def self.hash(key)
    redis.hgetall key
  end

  def self.list(key)
    redis.lrange key, 0, -1
  end

  def self.set(key)
    redis.smembers key
  end

  def self.zset(key)
    sorted_set = redis.zrange key, 0, -1
    sorted_set.collect do |value|
      {'value' => value, 'score' => redis.zscore(key, value)}
    end
  end

  def self.string(key)
    redis.get key
  end
end
