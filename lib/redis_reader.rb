module RedisReader
  def self.redis
    AppConfig::Redis.connection
  end

  def self.command(key)
    {
      :hash   => [:hgetall, key],
      :list   => [:lrange, key, 0, -1],
      :set    => [:smembers, key],
      :zset   => [:zrange, key, 0, -1],
      :string => [:get, key],
    }
  end

  def self.get(key)
    type = redis.type(key).to_sym
    value = redis.send(*command(key)[type])
    result = {:key => key, :type => type, :value => value}
    if type == :zset
      result[:value].collect! do |member|
        {:value => member, :score => redis.zscore(key, member), :rank => redis.zrank(key, member)}
      end
    end
    result
  end

  def self.dump
    redis.keys.inject([]) do |arr, key|
      arr << get(key)
      arr
    end
  end
end
