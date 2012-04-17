class RedisAbstractor
  def self.redis
    AppConfig::Redis.instance
  end

  def self.info
    RedisCommand.info
  end

  def self.get_info(key)
    info[key]
  end

  def self.databases
    db_nums = (0...AppConfig::Redis::MAX_DATABASES).to_a
    db_nums.inject({}) do | dbs, db_num |
      dbs["#{db_num}"] = (databases_with_data["db#{db_num}"] || nil)
      dbs
    end
  end

  def self.databases_with_data
    Hash.try_convert(info.select{ |k,v| k.match(/^db(\d+)$/) })
  end

  def self.dump
    get(keys)
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

  def self.get_value(key)
    type  = RedisCommand.type(key)
    value = RedisCommand.get_all(type, key)
    {'key' => key, 'type' => type, 'value' => value}
  end

  def self.del(key)
    redis.del(key)
  end

  def self.delete_all
    keys.each { |k| del(k) }
  end
end
