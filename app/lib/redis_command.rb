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

  def self.get_all(type, key)
    self.send("#{type}_all", key)
  end

  def self.ttl(key)
    time = redis.ttl(key)
    time < 0 ? nil : time
  end

  def self.hash(key)
    hash_all(key)
  end

  def self.hash_all(key)
    redis.hgetall(key)
  end

  def self.list(key)
    list_all(key)
  end

  def self.list_all(key)
    redis.lrange key, 0, -1
  end

  def self.set(key)
    redis.smembers(key).compact
  end

  def self.set_all(key)
    redis.smembers(key)
  end

  def self.zset(key)
    zset_all(key)
  end

  def self.zset_all(key)
    redis.zrange(key, 0, -1).collect do |value|
      score = redis.zscore(key, value)
      { "value" => value, "score" => score }
    end
  end

  def self.string(key)
    redis.get key
  end

  def self.string_all(key)
    redis.get key
  end

  def self.info
    redis.info
  end
end
