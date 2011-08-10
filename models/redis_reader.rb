class RedisReader
  attr_accessor :redis

  def initialize
    @redis = Redis.new
  end

  def dump
    redis.keys.inject([]) do |arr, key|
      type = redis.type(key)
      value = get(key, type)
      arr << {:key => key.inspect, :type => type, :value => value.inspect}
      arr
    end
  end

  def get(key, type)
    puts "key: #{key} type: #{type}"
    case type.to_sym
    when :hash
      redis.hgetall(key)
    when :list
      redis.lrange(key, 0, -1)
    when :set
      redis.smembers(key)
    when :zset
      redis.zrange(key, 0, -1)
    when :string
      redis.get(key)
    else
      raise 'Unknown type'
    end

  end
end
